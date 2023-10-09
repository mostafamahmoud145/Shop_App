
import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Search_screen/cubit/states.dart';
import '../../../models/SearchModel/SearchModel.dart';
import '../../../shared/conestants/consetanst.dart';
import '../../../shared/network/remote/DioHelper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(super.SearchInitialState);
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchProductModel? searchProductModel;

  void getSearch({required String text}){
    emit(SearchLoadingState());
    DioHelper.postData(
        token: token,
        url: SEARCH,
        query: {},
        data: {
          'text':text,
        }).then((value){
      searchProductModel = SearchProductModel.fromJson(value.data);
      print(value);
      emit(SearchSucceedState());
    }).catchError((error){
      emit(SearchErrorState());
      print("errorrrrrrr$error");
    });
  }
}