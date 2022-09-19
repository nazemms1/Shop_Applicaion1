
import '../../modules/shop_app_new/login/shop_login_new.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void singOut(context) {
  CacheHelper.removeData(key: 'token',).then((value) {
    if (value) {
      navigateAndFinish(context, LoginShopNew(),);
    }
  });
}
late String token='iU6gv95rhqFapoAgEGHGoHYHGfR7QK0q6Q9YZNJINcDjVm7n5UqZrEAueb4KySB8V1fz8u';
late String ?uId;