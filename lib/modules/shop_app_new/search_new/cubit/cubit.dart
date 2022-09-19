import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application1/modules/shop_app_new/search_new/cubit/state.dart';

import '../../../../models/shop_app_new/search_model_new.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/endpoints.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModelNew? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      model=SearchModelNew.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SearchErrorState());
    });
  }
}
