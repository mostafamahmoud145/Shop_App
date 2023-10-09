import '../../../models/LoginModel/login_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginSucceedState extends LoginStates{
  final LoginModel loginModel;
  LoginSucceedState(this.loginModel);
}
class LoginLoadingState extends LoginStates{}
class LoginErrorState extends LoginStates{}