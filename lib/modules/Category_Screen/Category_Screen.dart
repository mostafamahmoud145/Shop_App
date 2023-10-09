import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/CategoriesModel/Categories_Model.dart';
import '../../shared/components/components.dart';
import '../Home_Screen/cubit/cubit.dart';
import '../Home_Screen/cubit/state.dart';
class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: HomeCubit.get(context).categoriesModel!.data.list.length!=0,
          builder: (context)=> ListView.separated(
            itemBuilder: (context, index) => buildCatItem(HomeCubit.get(context).categoriesModel!.data.list[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: HomeCubit.get(context).categoriesModel!.data.list.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(model.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}