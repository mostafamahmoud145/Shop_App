import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/conestants/consetanst.dart';
import '../Home_Screen/cubit/cubit.dart';
import '../Home_Screen/cubit/state.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        return ConditionalBuilder(
          condition: HomeCubit.get(context).profileModel != null,
          builder: (context) {
            nameController.text = HomeCubit.get(context).profileModel!.data.name;
            emailController.text = HomeCubit.get(context).profileModel!.data.email;
            phoneController.text = HomeCubit.get(context).profileModel!.data.phone;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children:
                    [
                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultText(
                        controller: nameController,
                        inputType: TextInputType.name,
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'name must not be empty';
                          }

                          return null;
                        },
                        text: 'Name',
                        prefix: Icons.person,
                        onChange: (String? value) {},
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultText(
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'email must not be empty';
                          }

                          return null;
                        },
                        text: 'Email Address',
                        prefix: Icons.email,
                        onChange: (value) {},
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultText(
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'phone must not be empty';
                          }

                          return null;
                        },
                        text: 'Phone',
                        prefix: Icons.phone,
                        onChange: (value) {},
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'update',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          HomeCubit.get(context).profileModel = null;
                          HomeCubit.get(context).loginModel = null;
                          HomeCubit.get(context).favoriteModel = null;
                          HomeCubit.get(context).changeFavoritesModel = null;
                          HomeCubit.get(context).homeModel = null;
                          HomeCubit.get(context).categoriesModel = null;
                          HomeCubit.get(context).favorites = {};
                          isLogOut = true;
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
