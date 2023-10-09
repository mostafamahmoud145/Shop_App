import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../Home_Screen/cubit/cubit.dart';
import '../Home_Screen/cubit/state.dart';

class FavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(HomeCubit.get(context).favoriteModel!.data.data[index].product, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: HomeCubit.get(context).favoriteModel!.data.data.length,
            physics: BouncingScrollPhysics(),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}