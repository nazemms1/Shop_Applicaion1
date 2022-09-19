

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application1/modules/shop_app_new/login/cubit/state.dart';

import '../../../../models/shop_app_new/login_model_new.dart';
import '../../../../shared/network/endpoints.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubitNew extends Cubit<ShopLoginNewStates> {
  ShopLoginCubitNew() : super(ShopLoginNewInitialState());

  static ShopLoginCubitNew get(context) => BlocProvider.of(context);
  late ShopLoginModelNew loginModelNew;
  void userLoginNew({
    required String email,
    required String password,
  }) {
    emit(ShopLoginNewLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value){

      print(value.data);
      loginModelNew= ShopLoginModelNew.fromJson(value.data);
      print(loginModelNew.data!.token);
      print(loginModelNew.status);
      print(loginModelNew.message);
      emit(ShopLoginNewSuccessState(loginModelNew));
    }).catchError((error)
    {
      emit(ShopLoginNewErrorState(error.toString()));
    });
  }
}
