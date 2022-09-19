import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application1/layout/shop_app_new/shop_layout_new.dart';
import 'package:shop_application1/modules/shop_app_new/onboarding/onboarding.dart';
import 'package:shop_application1/shared/bloc_observer.dart';
import 'package:shop_application1/shared/components/constants.dart';
import 'package:shop_application1/shared/cubit/cubit.dart';
import 'package:shop_application1/shared/cubit/states.dart';
import 'package:shop_application1/shared/network/local/cache_helper.dart';
import 'package:shop_application1/shared/network/remote/dio_helper.dart';
import 'package:shop_application1/styles/themes.dart';

import 'layout/shop_app_new/cubit/cubit.dart';
import 'modules/shop_app_new/login/shop_login_new.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  // bool ?onBoarding=CacheHelper.getData(key:'boarding');
  // print(onBoarding );

//String ? token =CacheHelper.getData(key:'token');
  uId = CacheHelper.getData(key: 'uId');

  // if(onBoarding !=null)
  //   {
  //     if(token !=null)
  //       {
  //         widget= const ShopLayoutNew();
  //       }
  //     else
  //     {
  //       widget=LoginShopNew();
  //     }
  //   }
  // else
  // {
  //   widget=const OnBoardingNewScreen();
  // }
  if (uId != null) {
    widget = ShopLayoutNew();
  } else {
    widget = LoginShopNew();
  }
  runApp(MyApp(
    isDark: isDark,
    starWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? starWidget;

  MyApp({
    //required this.isDark,
    required this.starWidget,
    required this.isDark,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              // fromShared: isDark,
            ),
        ),

        BlocProvider(
          create: (BuildContext context) => ShopCubitNew()
            ..getHomeDataNew()
            ..getCategoriesNew()
            ..getFavoritesNew()
            ..getUserDataNew(),
        ),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            // themeMode: ThemeMode.dark,
            home: starWidget,
          );
        },
      ),
    );
  }
}

