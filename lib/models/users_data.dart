import 'dart:io';

class Users {
  String name;
  String number;
  String email;
  File image;

  Users(
      {required this.name,
      required this.number,
      required this.email,
      required this.image});
}
