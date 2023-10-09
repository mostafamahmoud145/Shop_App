import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/shared%20preferences/shared_preferences.dart';
import '../../modules/login_screen/LoginScreen.dart';

const LOGIN= 'login';
const REGISTER= 'register';
const HOME= 'home';
const CATEGORIES= 'categories';
const FAVORITES= 'favorites';
const PROFILE= 'profile';
const SEARCH= 'products/search';
const UPDATE_PROFILE= 'update-profile';
String? token;
bool isLogOut = false;
Widget? widget;

void signOut(context)
{
  CashHelper.clearData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      NavigateAndReplace(
        context,
        LoginScreen(),
      );
    }
  });
}