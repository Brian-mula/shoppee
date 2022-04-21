import 'dart:convert';

class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;
  UserModel(
      {required this.email,
      required this.id,
      required this.name,
      required this.orderCount,
      required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        id: json['id'],
        name: json['name'],
        orderCount: json['order_count'],
        phone: json['phone']);
  }
}
