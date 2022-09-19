class ChangeFavoritesModelNew
{
  late bool status;

  late String message;
  ChangeFavoritesModelNew.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}