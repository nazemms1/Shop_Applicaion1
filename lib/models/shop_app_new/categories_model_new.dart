class CategoriesModelNew {
  late bool status;
  late CategoriesDataModelNew data;

  CategoriesModelNew.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModelNew.fromJson(json['data']);
  }
}

class CategoriesDataModelNew {
  late int current_page;
  late List<DataModelNew> data = [];

  CategoriesDataModelNew.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModelNew.fromJson(element));
    });
  }
}

class DataModelNew {
  late int id;
  late String name;
  late String image;

  DataModelNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];

    image = json['image'];
  }
}
