import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import '../../../layout/shop_app_new/cubit/cubit.dart';


import '../../../layout/shop_app_new/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../styles/icon_broken.dart';

class SettingsScreenNew extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitNew, ShopStatesNew>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataStateNew) {
          //   print(state.loginModelNew!.data.name);
          //   print(state.loginModelNew!.data.phone);

        }

      },
      builder: (context, state) {

        var profile = ShopCubitNew.get(context).profileModel;
        nameController.text = ShopCubitNew.get(context).profileModel != null
            ? profile!.data!.name!
            : "";
        emailController.text = ShopCubitNew.get(context).profileModel != null
            ? profile!.data!.email!
            : "";
        phoneController.text = ShopCubitNew.get(context).profileModel != null
            ? profile!.data!.phone!
            : "";

        return ConditionalBuilder(

          condition: ShopCubitNew.get(context).profileModel != null,
          builder: (context) =>  Padding(

            padding: const EdgeInsets.all(20),
            child: Form(

              key: formkey,
              child: Column(

                children: [
                  if(state is ShopLoadingUserDataStateNew)
                    LinearProgressIndicator(),
                  SizedBox(height: 20.0,),


                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: IconBroken.Profile,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefix: IconBroken.Message,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: IconBroken.Call,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),  defaultButton(
                    text: 'UPDATE',
                    function: () {
                      if (formkey.currentState!.validate()) {
                        ShopCubitNew.get(context).updateUserDataNew(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
