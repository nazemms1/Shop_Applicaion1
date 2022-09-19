import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application1/modules/shop_app_new/register/cubit/state.dart';

import '../../../../models/shop_app_new/profile_model.dart';
import '../../../../shared/network/endpoints.dart';
import '../../../../shared/network/remote/dio_helper.dart';


class ShopRegisterCubitNew extends Cubit<ShopRegisterNewStates> {
  ShopRegisterCubitNew() : super(ShopRegisterNewInitialState());

  static ShopRegisterCubitNew get(context) => BlocProvider.of(context);
  late ProfileModel profileModel;
  void userRegisterNew({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterNewLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email': email,
        'password': password,
       'phone':phone,
      },
    ).then((value){

      print(value.data);
      profileModel= ProfileModel.fromJson(value.data);

      emit(ShopRegisterNewSuccessState(profileModel));
    }).catchError((error)
    {print(error.toString());
      emit(ShopRegisterNewErrorState(error.toString()));
    });
  }
}
