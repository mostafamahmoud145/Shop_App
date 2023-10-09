import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/ShopLayout.dart';
import 'package:shop_app/modules/login_screen/LoginScreen.dart';
import 'package:shop_app/modules/onBoarding/onboarding.dart';
import 'package:shop_app/shared/components/bloc_observer.dart';
import 'package:shop_app/shared/conestants/consetanst.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';
import 'package:shop_app/shared/shared%20preferences/shared_preferences.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/Home_Screen/cubit/cubit.dart';
import 'modules/Home_Screen/cubit/state.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? onBoarding=CashHelper.getData(key: 'onBoarding');
  token=CashHelper.getData(key: 'token');

  if(onBoarding == true)
    {
      if(token != null)
        {
          widget = ShopLayout();
          print(token);
        }
      else
        {
          widget = LoginScreen();
        }
    }
  else
    {
      widget = OnBoarding();
    }
  DioHelper.init();
  runApp(MyApp(widget!));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomeCubit(HomeInitialState())..getHomeData()..getCategoriesData()..getFavoriteData()..getUserData()),
      ], child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: widget,
          ),
    );
  }
}

