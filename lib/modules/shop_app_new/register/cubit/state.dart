
import '../../../../models/shop_app_new/profile_model.dart';

abstract class ShopRegisterNewStates{}
class ShopRegisterNewInitialState extends ShopRegisterNewStates{}

class ShopRegisterNewLoadingState extends ShopRegisterNewStates{}
class ShopRegisterNewSuccessState extends ShopRegisterNewStates
{
 late final ProfileModel profileModel;
 ShopRegisterNewSuccessState(this.profileModel);
}
class ShopRegisterNewErrorState extends ShopRegisterNewStates{
 late final String error;
 ShopRegisterNewErrorState(this.error);

}
