class ShopLoginModelNew {
   bool ?status;
   String ?message;
  UserDataNew?  data;
  ShopLoginModelNew.fromJson(Map<String, dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']==null ?null: UserDataNew.fromJson(json['data']);
  }
}

class UserDataNew {
int   ?id;
String?name;
String?email;
String?phone;
String?image;
int   ?points;
int   ? credit;
 String?  token;

// UserDataNew({
//   required this.id,
//   required this.name,
//   required this.email,
//   required this.phone,
//   required this.image,
//   required this.points,
//   required this.credit,
//   required this.token,
// });
UserDataNew.fromJson(Map<String, dynamic>json)
{
  id=json['id'];
  name=json['name'];
  email=json['email'];
  phone=json['phone'];
  image=json['image'];
  points=json['points'];
  credit=json['credit'];
  token=json['toke'];
}
}
