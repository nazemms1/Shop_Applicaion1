
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/NavBar/navbar_screen.dart';
import '../../modules/shop_app_new/search_new/search_screen_new.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayoutNew extends StatelessWidget {
  const ShopLayoutNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitNew, ShopStatesNew>(
      listener: (context, state) {},
      builder: (context, state) {
        var Cubit = ShopCubitNew.get(context);
        return Scaffold(
          backgroundColor: Colors.orange.shade100,
drawer: NavBar(),
          appBar: AppBar(
            title: Text('SHOP'),
            // flexibleSpace:  Image(
            //   image: AssetImage('assets/images/29.png'),
            //
            // ),
            // backgroundColor: Colors.white,

            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreenNew(),);
              },
                icon: Icon(IconBroken.Search),),
              TextButton(onPressed: (){ singOut(context);},
                  child: Text('Logout')),

            ],
          ),
          body: Cubit.bottomScreensNew[Cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              Cubit.changeBottom(index);
            },
            currentIndex: Cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Heart),
                label: 'favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',

              ),
            ],
          ),
        );
      },
    );
  }
}
