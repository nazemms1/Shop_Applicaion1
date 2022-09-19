
import '../../../../models/shop_app_new/login_model_new.dart';

abstract class ShopLoginNewStates{}
class ShopLoginNewInitialState extends ShopLoginNewStates{}

class ShopLoginNewLoadingState extends ShopLoginNewStates{}
class ShopLoginNewSuccessState extends ShopLoginNewStates
{
 late final ShopLoginModelNew loginModelNew;
 ShopLoginNewSuccessState(this.loginModelNew);
}
class ShopLoginNewErrorState extends ShopLoginNewStates{
 late final String error;
 ShopLoginNewErrorState(this.error);

}
