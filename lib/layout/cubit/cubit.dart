import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/state.dart';
import '../../modules/Category_Screen/Category_Screen.dart';
import '../../modules/Favorite_Screen/Favorite_Screen.dart';
import '../../modules/Home_Screen/Home Screen.dart';
import '../../modules/Settings_Screen/Settings_Screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(super.ShopInitialState);

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}