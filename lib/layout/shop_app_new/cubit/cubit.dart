
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application1/layout/shop_app_new/cubit/states.dart';

import '../../../models/shop_app_new/categories_model_new.dart';
import '../../../models/shop_app_new/change_favorites_model_new.dart';
import '../../../models/shop_app_new/favorites_model_new.dart';
import '../../../models/shop_app_new/home_new_models.dart';
import '../../../models/shop_app_new/profile_model.dart';
import '../../../modules/shop_app_new/categories_new/categories_screen_new.dart';
import '../../../modules/shop_app_new/favorites_new/favorites_screen_new.dart';
import '../../../modules/shop_app_new/products_new/products_screen_new.dart';
import '../../../modules/shop_app_new/settings_new/settings_screen_new.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/endpoints.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubitNew extends Cubit<ShopStatesNew> {
  ShopCubitNew() : super(ShopInitialStateNew());

  static ShopCubitNew get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreensNew = [
    ProductsScreenNew(),
    CategoriesScreenNew(),
    FavoritesScreenNew(),
    SettingsScreenNew(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavStateNew());
  }

  HomeModelNew? homeModelNew;

  Map<int, bool> favorites = {};

  void getHomeDataNew() {
    emit(ShopLoadingHomeDataStateNew());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModelNew = HomeModelNew.fromJson(value.data);

      // printFullText(homeModelNew!.data.banners[0].image);
      // print(homeModelNew!.status);
      homeModelNew!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataStateNew());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataStateNew());
    });
  }

  CategoriesModelNew? categoriesModelNew;

  void getCategoriesNew() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModelNew = CategoriesModelNew.fromJson(value.data);

      emit(ShopSuccessCategoriesStateNew());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesStateNew());
    });
  }

  ChangeFavoritesModelNew? changeFavoritesModelNew;

  void changeFavoritesNew(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesStateNew());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModelNew = ChangeFavoritesModelNew.fromJson(value.data);
      // print(value.data);
      if (!changeFavoritesModelNew!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesNew();
      }

      emit(ShopSuccessChangeFavoritesStateNew(changeFavoritesModelNew!));
    }).catchError((onError) {
      favorites[productId] = !favorites[productId]!;
      print(onError.toString());
      emit(ShopErrorChangeFavoritesStateNew());
    });
  }

  FavoritesModelNew? favoritesModelNew;

  void getFavoritesNew() {
    emit(ShopLoadingGetFavoriterStateNew());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModelNew = FavoritesModelNew.fromJson(value.data);
// printFullText(value.data.toString());
      emit(ShopSuccessGetFavoriterStateNew());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoriterStateNew());
    });
  }

  ProfileModel? profileModel;

  void getUserDataNew() {
    emit(ShopLoadingUserDataStateNew());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      //    printFullText(usermodelnew.data.name);
      emit(ShopSuccessUserDataStateNew(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStateNew());
    });
  }

  void updateUserDataNew({required String name,required String email,required
  String phone,}) {
    emit(ShopLoadingUserDataStateNew());
    DioHelper.putData(
      url: UPDATEPROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      //    printFullText(usermodelnew.data.name);
      emit(ShopSuccessUpdateUserStateNew(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserStateNew());
    });
  }
}
