class HomeModelNew {
  late bool status;
  late HomeDataModelNew data;

  HomeModelNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModelNew.fromJson(json['data']);
  }
}

class HomeDataModelNew {
  List<BannerModelNew> banners = [];
  List<ProductModelNew> products = [];

  HomeDataModelNew.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModelNew.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModelNew.fromJson(element));
    });
  }
}

class BannerModelNew {
  late int id;
  late String image;

  BannerModelNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModelNew {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModelNew.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
   image=json['image'];
   name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];

  }
}
