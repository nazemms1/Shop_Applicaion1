import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_new/cubit/cubit.dart';
import '../../../layout/shop_app_new/cubit/states.dart';
import '../../../models/shop_app_new/categories_model_new.dart';

class CategoriesScreenNew extends StatelessWidget {
  const CategoriesScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitNew, ShopStatesNew>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildListCategry(
              ShopCubitNew.get(context).categoriesModelNew!.data.data[index]),
          separatorBuilder: (context, index) => SizedBox(
            height: 10,
          ),
          itemCount:
              ShopCubitNew.get(context).categoriesModelNew!.data.data.length,
        );
      },
    );
  }

  Widget buildListCategry(DataModelNew modelNew) => InkWell(
    onTap: (){},
   child:   Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image(
              image: NetworkImage(modelNew.image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              modelNew.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ),
      ),
      );
}
