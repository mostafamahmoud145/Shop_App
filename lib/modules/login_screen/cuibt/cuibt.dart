import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/LoginModel/login_model.dart';
import 'package:shop_app/modules/login_screen/cuibt/states.dart';
import 'package:shop_app/shared/network/remote/DioHelper.dart';

import '../../../models/ProfileModel/ProfileModel.dart';
import '../../../shared/conestants/consetanst.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(super.LoginInitialState);

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        token: token,
        url: LOGIN,
        query: {},
        data: {
          'email': email,
          'password': password,
        }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel?.message);
      emit(LoginSucceedState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState());
      print(error);
    });
  }
}
