import 'package:flutter/widgets.dart';

class RegisterModel{
  late bool status;
  late String message;
  late DataModel data;

  RegisterModel.fromJson(Map<String,dynamic>list){
    status = list['status'];
    message = list['message'];
    data = DataModel.fromJson(list['data']);
  }

}
class DataModel{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  DataModel.fromJson(Map<String,dynamic>data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    token = data['token'];
  }
}