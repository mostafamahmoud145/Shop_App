import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Search_screen/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';

import 'cubit/states.dart';

class SearchScreen extends StatelessWidget{
  TextEditingController searchController = TextEditingController();
  bool prog = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(SearchInitialState()),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  defaultText(controller: searchController, text: "Search", prefix: Icons.search, inputType: TextInputType.text, valid: (value){
                    if(value==null|| value.isEmpty)
                    {
                      return "please enter product name to search";
                    }
                  },
                    onChange: (value){},
                    onSubmit: (value){
                    SearchCubit.get(context).getSearch(text: value.toString());
                    },
                  ),
                  if(state is SearchSucceedState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: SearchCubit.get(context).searchProductModel!.data.data.length,
                          itemBuilder: (context,index)=>buildSearchListProduct(SearchCubit.get(context).searchProductModel!.data.data[index], context),
                          separatorBuilder: (BuildContext context, int index) =>myDivider(),

                        ),
                      ),
                  if(state is SearchLoadingState)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}