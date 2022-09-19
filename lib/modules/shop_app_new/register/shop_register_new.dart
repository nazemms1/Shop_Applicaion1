
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_new/shop_layout_new.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterShopNew extends StatelessWidget {
  late var forkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubitNew(),
      child: BlocConsumer<ShopRegisterCubitNew, ShopRegisterNewStates>(
        listener: (context, state) {
          if (state is ShopRegisterNewSuccessState)
          {
            if (state.profileModel.status!)
            {
               print(state.profileModel.data!.token);


              CacheHelper.saveData(
                key: 'token',
                value: state.profileModel.data!.token,
              ).then((value) {
                token = state.profileModel.data!.token!;
                navigateAndFinish(context, const ShopLayoutNew());
              });
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Register',
              ),
            ),
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
                          'Register',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: IconBroken.Add_User,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix:  IconBroken.Message,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'please enter your Email  Address';
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
                          prefix: IconBroken.Password,
                          sufix:  IconBroken.Show,
                          validate: (String ?value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix:IconBroken.Call,
                          validate: (String ?value) {
                            if (value!.isEmpty) {
                              return 'Please enter your  Phone';
                            }
                            return null;
                          },
                        ),

                        SizedBox(
                          height: 30,
                        ),

                        //   (state is ShopLoginNewLoadingState)?const Center(child:
                        //   CircularProgressIndicator()):Container(
                        //   width: double.infinity,
                        //   color: Colors.blue,
                        //   child: MaterialButton(
                        //       child: const Text(
                        //         "loge in",
                        //         style:
                        //         TextStyle(fontSize: 25, color: Colors.white),
                        //       ),
                        //       onPressed: () {
                        //         if(forkey.currentState!.validate()){
                        //           ShopLoginCubitNew.get(context).userLoginNew
                        //             (email: emailController.text, password:
                        //           passController.text);
                        //         }navigateAndFinish(context, ShopLayoutNew());
                        //       }),
                        // ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterNewLoadingState,
                          builder: (context) => defaultButton(
                            text: 'Register',
                            function: () {
                              if (forkey.currentState!.validate()) {
                                ShopRegisterCubitNew.get(context)
                                    .userRegisterNew(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                );

                                // navigateTo(context, const ShopLayoutNew());
                              }
                              // (state is ShopRegisterNewErrorState) {
                              //   Fluttertoast.showToast(
                              //     msg: 'Error',
                              //     toastLength: Toast.LENGTH_LONG,
                              //     gravity: ToastGravity.BOTTOM,
                              //     timeInSecForIosWeb: 5,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.black,
                              //     fontSize: 16.0,
                              //   );

                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
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
