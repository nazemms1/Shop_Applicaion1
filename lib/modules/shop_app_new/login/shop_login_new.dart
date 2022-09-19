import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../layout/shop_app_new/shop_layout_new.dart';
import '../../../shared/adaptive/adaptive_indicator.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../register/shop_register_new.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginShopNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var forkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubitNew(),
      child: BlocConsumer<ShopLoginCubitNew, ShopLoginNewStates>(
        listener: (context, state) {
          if (state is ShopLoginNewSuccessState) {
            if (state.loginModelNew.status!) {
              print(state.loginModelNew.data!.token);
              print(state.loginModelNew.message!);
              Fluttertoast.showToast(
                msg: state.loginModelNew.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                fontSize: 16.0,
              );
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModelNew.data!.token!,
              ).then((value) {
                token = state.loginModelNew.data!.token!;
                navigateAndFinish(context, ShopLayoutNew());
              });
              // Fluttertoast.showToast(
              //   msg: state.loginModelNew.message!,
              //   textColor: Colors.green,
              // );
            } else {
              print(state.loginModelNew.message);
              Fluttertoast.showToast(
                msg: state.loginModelNew.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: forkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            prefix: Icons.lock,
                            sufix: Icons.visibility_outlined,
                            isPassword: true,
                            onSubmit: (value) {
                              if (forkey.currentState!.validate()) {
                                ShopLoginCubitNew.get(context).userLoginNew(
                                  email: emailController.text,
                                  password: passController.text,
                                );

                              }   navigateAndFinish(context, ShopLayoutNew());
                            } ,
                          validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                            },
                          ),
                        SizedBox(
                          height: 30.0,
                        ),

                          (state is ShopLoginNewLoadingState)?
                              defaultButton(
                                function: () {
                                  if (forkey.currentState!.validate()) {
                                    ShopLoginCubitNew.get(context).userLoginNew(
                                      email: emailController.text,
                                      password: passController.text,
                                    );
                                  }
                                },

                        text: 'Login', ):Center(
                              child: AdaptiveIndicator(
                                os:'android',
                              )),
                        // ConditionalBuilder(
                        //   condition: state is! ShopLoginNewLoadingState,
                        //   builder: (context) => defaultButton(
                        //     text: 'login',
                        //     function: () {
                        //       if (forkey.currentState!.validate()) {
                        //         ShopLoginCubitNew.get(context).userLoginNew(
                        //             email: emailController.text,
                        //             password: passController.text);
                        //       }
                        //       navigateAndFinish(context, ShopLayoutNew());
                        //     },
                        //   ),
                        //   fallback: (context) =>
                        //       Center(child: CircularProgressIndicator()),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dont have anyacount?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterShopNew());
                              },
                              text: 'Register',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
