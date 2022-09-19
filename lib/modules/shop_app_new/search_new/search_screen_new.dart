import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_new/cubit/cubit.dart';
import '../../../layout/shop_app_new/cubit/states.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SearchScreenNew extends StatelessWidget {
  const SearchScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(

      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SearchLoadingState)
          LinearProgressIndicator();
          return Scaffold(
    backgroundColor: Colors.grey.shade100,
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(


                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          label: 'Search for any product.. ' ,
                          prefix: Icons.search,
                          onSubmit: (String text) {
                            SearchCubit.get(context).search(text);
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Enter text to search';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(color: Colors.black,),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length,
                          ),
                        ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
