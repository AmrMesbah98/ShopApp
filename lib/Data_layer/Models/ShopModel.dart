class ShopLoginModel {
  bool status;
  String message;
  UserData? data;

  ShopLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShopLoginModel.fromJson(Map<String, dynamic> Json) {
    return ShopLoginModel(
      status: Json['status'],
      message: Json['message'],
      data: Json['data'] != null ? UserData.fromJson(Json['data']) : null,
    );
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> Json) {
    return UserData(
      id: Json['id'],
      name: Json['name'],
      email: Json['email'],
      phone: Json['phone'],
      image: Json['image'],
      points: Json['points'],
      credit: Json['credit'],
      token: Json['token'],
    );
  }
}
