import 'package:flutter/material.dart';
import 'package:shop_application1/modules/shop_app_new/favorites_new'
    '/favorites_screen_new'
    '.dart';
import 'package:shop_application1/modules/shop_app_new/search_new'
    '/search_screen_new'
    '.dart';
import 'package:shop_application1/styles/icon_broken.dart';

import '../../layout/shop_app_new/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../shop_app_new/categories_new/categories_screen_new.dart';
import '../shop_app_new/settings_new/settings_screen_new.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = ShopCubitNew.get(context).profileModel;

    return Drawer(
    backgroundColor: Colors.blue.shade50,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${user!.data!.name}'),
            accountEmail: Text(
              '${user.data!.email}',
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  '${user.data!.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://img.freepik.com/free-photo/young-lady-use-cellphone-order-online-shopping-product-paying-bills-with-banking-app-with-transaction-successful-stay-house-quarantine-activity-fun-activity-coronavirus-prevention_7861-3270.jpg?w=900&t=st=1661977667~exp=1661978267~hmac=f7f4453153ee1163639bcb8d43ef502cf12fbd153a9bdc08f86fdd5de83b7676'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(IconBroken.Heart),
            title: Text('Favorites'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconBroken.Home),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconBroken.Category),
            title: Text('Categories'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconBroken.Setting),
            title: Text('Settings'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(IconBroken.Search),
            title: Text('Search'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(IconBroken.Notification),
            title: Text('Request'),
            trailing: ClipOval(
              child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
