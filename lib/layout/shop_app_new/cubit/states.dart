
import '../../../models/shop_app_new/change_favorites_model_new.dart';
import '../../../models/shop_app_new/profile_model.dart';

abstract class ShopStatesNew {}

class ShopInitialStateNew extends ShopStatesNew {}

class ShopChangeBottomNavStateNew extends ShopStatesNew {}

class ShopLoadingHomeDataStateNew extends ShopStatesNew {}

class ShopSuccessHomeDataStateNew extends ShopStatesNew {}

class ShopErrorHomeDataStateNew extends ShopStatesNew {}

class ShopSuccessCategoriesStateNew extends ShopStatesNew {}

class ShopErrorCategoriesStateNew extends ShopStatesNew {}

class ShopSuccessChangeFavoritesStateNew extends ShopStatesNew {
  late final ChangeFavoritesModelNew modelNew;

  ShopSuccessChangeFavoritesStateNew(this.modelNew);
}

class ShopChangeFavoritesStateNew extends ShopStatesNew {}

class ShopErrorChangeFavoritesStateNew extends ShopStatesNew {}

class ShopSuccessGetFavoriterStateNew extends ShopStatesNew {}

class ShopErrorGetFavoriterStateNew extends ShopStatesNew {}

class ShopLoadingGetFavoriterStateNew extends ShopStatesNew {}

class ShopSuccessUserDataStateNew extends ShopStatesNew {
  late final ProfileModel profileModel;

  ShopSuccessUserDataStateNew(this.profileModel);
}

class ShopErrorUserDataStateNew extends ShopStatesNew {}

class ShopLoadingUserDataStateNew extends ShopStatesNew {}

class ShopSuccessUpdateUserStateNew extends ShopStatesNew {
  late final ProfileModel profileModel;

  ShopSuccessUpdateUserStateNew(this.profileModel);
}

class ShopErrorUpdateUserStateNew extends ShopStatesNew {}

class ShopLoadingUpdateUserStateNew extends ShopStatesNew {}
