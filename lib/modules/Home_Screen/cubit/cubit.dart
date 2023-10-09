import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/CategoriesModel/Categories_Model.dart';
import 'package:shop_app/models/FavoriteModel/FavoriteModel.dart';
import 'package:shop_app/models/HomeModel/Home_model.dart';
import 'package:shop_app/modules/Home_Screen/cubit/state.dart';
import 'package:shop_app/shared/conestants/consetanst.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';
import '../../../models/ChangeFavouriteModel/ChangeFavoriteModel.dart';
import '../../../models/LoginModel/login_model.dart';
import '../../../models/ProfileModel/ProfileModel.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(super.HomeInitialState);
  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: HOME,
      query: {},
      token: token,
    ).then((value) {
      //print(value);
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      print(favorites.toString());
      emit(HomeSucceedState());
    }).catchError((error) {
      emit(HomeErrorState());
      print(error);
    });
  }

  ProfileModel? profileModel;
  void getUserData() {
    emit(UserLoadingState());
    DioHelper.getData(url: PROFILE, query: {}, token: token).then((value) {
      print(value);
      profileModel = ProfileModel.fromJson(value.data);
      emit(UserSucceedState());
    }).catchError((error) {
      emit(UserErrorState());
      print(error);
    });
  }

  Map<int, bool> favorites = {};
  void getFavoriteData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      query: {},
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
      print(error);
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  FavoriteModel? favoriteModel;
  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      query: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoriteData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
      print(error);
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
      query: {},
      token: token,
    ).then((value) {
      print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print(categoriesModel);

      emit(CategoriesSucceedState());
    }).catchError((error) {
      emit(CategoriesErrorState());
      print(error);
    });
  }

  void clearInf() {
    profileModel = null;
    loginModel = null;
    favoriteModel = null;
    changeFavoritesModel = null;
    homeModel = null;
    categoriesModel = null;
    favorites = {};
  }

  LoginModel? loginModel;
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(value.data);

      emit(ShopSuccessUpdateUserState(loginModel!));
      getUserData();
    }).catchError((error) {
      print("errororooror${error.toString()}");
      emit(ShopErrorUpdateUserState());
    });
  }
}
