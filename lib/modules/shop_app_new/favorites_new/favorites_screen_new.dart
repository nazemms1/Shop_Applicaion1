import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_new/cubit/cubit.dart';
import '../../../layout/shop_app_new/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../styles/colors.dart';

class FavoritesScreenNew extends StatelessWidget {
  const FavoritesScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitNew, ShopStatesNew>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(condition: state is! ShopLoadingGetFavoriterStateNew,
            builder: (context)=>ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  ShopCubitNew.get(context).favoritesModelNew!.data!
                      .data![index].product,
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
              ShopCubitNew.get(context).favoritesModelNew!.data!.data!.length,
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(),),);
      },
    );
  }


}
