import '../../../models/ChangeFavouriteModel/ChangeFavoriteModel.dart';
import '../../../models/LoginModel/login_model.dart';
import '../../../models/ProfileModel/ProfileModel.dart';

abstract class HomeStates{}
class HomeInitialState extends HomeStates{}

class HomeSucceedState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeErrorState extends HomeStates{}

class UserLoadingState extends HomeStates{}
class UserSucceedState extends HomeStates{}
class UserErrorState extends HomeStates{}

class CategoriesSucceedState extends HomeStates{}
class CategoriesLoadingState extends HomeStates{}
class CategoriesErrorState extends HomeStates{}

class ShopChangeFavoritesState extends HomeStates{}
class ShopErrorChangeFavoritesState extends HomeStates{}
class ShopSuccessChangeFavoritesState extends HomeStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopLoadingGetFavoritesState extends HomeStates{}
class ShopSuccessGetFavoritesState extends HomeStates{}
class ShopErrorGetFavoritesState extends HomeStates{}

class ShopErrorUpdateUserState extends HomeStates{}
class ShopLoadingUpdateUserState extends HomeStates{}
class ShopSuccessUpdateUserState extends HomeStates{
  final LoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}


