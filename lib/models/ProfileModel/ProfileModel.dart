import 'package:flutter/widgets.dart';

class ProfileModel{
  late bool status;
  late Null message;
  late DataModel data;

  ProfileModel.fromJson(Map<String,dynamic>list){
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
  late int points;
  late int credit;
  late String token;

  DataModel.fromJson(Map<String,dynamic>data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  }
}