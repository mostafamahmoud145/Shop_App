import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/ShopLayout.dart';
import 'package:shop_app/modules/Home_Screen/cubit/cubit.dart';
import 'package:shop_app/modules/RegisterScreen/RegisterScreen.dart';
import 'package:shop_app/modules/login_screen/cuibt/cuibt.dart';
import 'package:shop_app/modules/login_screen/cuibt/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/shared%20preferences/shared_preferences.dart';
import '../../shared/conestants/consetanst.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final globkey = GlobalKey<FormState>();
  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> LoginCubit(LoginInitialState()),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state){
          if(state is LoginSucceedState) {
            if (state.loginModel.status) {
              token = state.loginModel.data.token;
              CashHelper.saveData(
                  key: "token", value: state.loginModel.data.token);
              if(isLogOut == true) {
                HomeCubit.get(context).getUserData();
                HomeCubit.get(context).getFavoriteData();
                HomeCubit.get(context).getHomeData();
                HomeCubit.get(context).getCategoriesData();
              }
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              NavigateAndReplace(context, ShopLayout());
              token = state.loginModel.data.token;
            }
            else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
              else if( state is LoginErrorState)
                {
                  Fluttertoast.showToast(
                      msg: "Email or password is wrong",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: globkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text("login now to browse our hot offers",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey.shade600,
                          ),),
                        SizedBox(
                          height: 30,
                        ),
                        defaultText(controller: emailController, text: "Email Address", inputType: TextInputType.emailAddress,prefix: Icons.email_outlined, valid: (value){
                          if(value == null || value.isEmpty)
                          {
                            return "Email Cannot Be Empty";
                          }
                        }, onChange: (value){}),
                        SizedBox(
                          height: 15,
                        ),
                        defaultText(controller: passwordController, text: "Password",inputType: TextInputType.visiblePassword,suffix: iconData,isPassword: isPassword,prefix: Icons.lock_outlined, function: (){
                          isPassword = !isPassword;
                          if(isPassword == false)
                            iconData = Icons.visibility_off;
                          else
                            iconData = Icons.remove_red_eye;
                          setState(() {

                          });
                        },valid: (value){
                          if(value == null || value.isEmpty)
                          {
                            return "Password Cannot Be Empty";
                          }
                        }, onChange: (value){}),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context)=>defaultButton(function: (){
                            if(globkey.currentState!.validate())
                            {
                              LoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                              //CashHelper.clearData(key: 'onBoarding');
                            }
                          }, text: "LOGIN"),
                          fallback: (context)=>Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                              style: TextStyle(
                                  fontSize: 16
                              ),),
                            SizedBox(
                              width: 3,
                            ),
                            defaultTextButton(function: (){
                              navigateTo(context, ShopRegisterScreen());
                            }, text: "REGISTER"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}