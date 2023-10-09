import 'package:dio/dio.dart';
import 'package:shop_app/shared/conestants/consetanst.dart';

class DioHelper{
  static Dio dio = Dio();

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      headers: {
        'Content-Type': 'application/json',
        'lang': 'en',
        'Authorization' : token,
      },
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
      required String url,
      required Map<String,dynamic> query,
      required String? token,}) async{

    dio.options.headers={'Content-Type': 'application/json',
    'lang': 'en',
    'Authorization' : token,};
      return await dio.get(
          url,
          queryParameters: query,);
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data, required String? token}) async{
    dio.options.headers={'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization' : token,};
    return await dio.post(
        url,
        queryParameters: query,
        data: data,
    );
  }
  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query,
    Map<String,dynamic>? data, required String? token}) async{
    dio.options.headers={'Content-Type': 'application/json',
      'lang': 'en',
      'Authorization' : token,};
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}