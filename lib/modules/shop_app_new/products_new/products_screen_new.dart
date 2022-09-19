
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_new/cubit/cubit.dart';
import '../../../layout/shop_app_new/cubit/states.dart';
import '../../../models/shop_app_new/categories_model_new.dart';
import '../../../models/shop_app_new/home_new_models.dart';
import '../../../styles/colors.dart';
import '../../../styles/icon_broken.dart';

class ProductsScreenNew extends StatelessWidget {
  const ProductsScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitNew, ShopStatesNew>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesStateNew)
        {
            if(!state.modelNew.status)
              {
                print('Hellp');
              }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubitNew.get(context).homeModelNew != null&&
              ShopCubitNew.get(context).categoriesModelNew !=null,
          builder: (BuildContext context) =>
              Homebuilder(ShopCubitNew.get(context).homeModelNew!,
                  ShopCubitNew.get(context).categoriesModelNew !,context),
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget Homebuilder(HomeModelNew modelNew,CategoriesModelNew
  categoriesModelNew,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: modelNew.data.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 300.0,
                  initialPage: 1,
                  viewportFraction: 1.1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,

                  scrollDirection: Axis.vertical,
                )),
            SizedBox(
              height: 10.0,
            ),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
    child:Column(crossAxisAlignment: CrossAxisAlignment.start,
      children:[
            Text(
              'CATEGORIES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  reverse:true,
                  addAutomaticKeepAlives:true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItemNew
                (categoriesModelNew.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(width: 10),
              itemCount: categoriesModelNew.data.data.length,
            ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'New Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
  ],
    ),
    ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount:1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 1,
                childAspectRatio:  1/ 0.9,
                children: List.generate(
                  modelNew.data.products.length,
                  (index) => buildGridProductNew(modelNew.data
                      .products[index],context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItemNew(DataModelNew modelNew) =>
      InkWell(
        onTap: (){},

      child:Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(modelNew.image),
            width: 100,
            height: 100,
          ),
          Container(
            color: Colors.black.withOpacity(.8),
            width: 100,
            child: Text(
              modelNew.name,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      );

  Widget buildGridProductNew(ProductModelNew modelNew, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(modelNew.image),
                  width: double.infinity,

                  height: 250,
                ),
                if (modelNew.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    modelNew.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18,
                      height: 1.1,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        modelNew.price.toString(),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 1.0,
                      ),
                      Text('\$',style: TextStyle(color: Colors.green,
                        fontSize: 13,),
                      ),

                      SizedBox(
                        width: 5.0,
                      ),
                      if (modelNew.discount != 0)
                        Text(
                          modelNew.oldPrice.toString(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                     IconButton(onPressed:
                         ()
                     {
                       ShopCubitNew.get(context).changeFavoritesNew(modelNew.id);
                   print(modelNew.id);
                     },
                         icon: CircleAvatar(
                           radius: 15.0,
                           backgroundColor: ShopCubitNew.get(context)
                              .favorites[modelNew.id]! ? defaultColor:Colors.grey,
                         child: Icon(
                         IconBroken.Heart,
                           size: 14.0,
                           color: Colors.white,
                         ),
                         ),
                     ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      );
}
