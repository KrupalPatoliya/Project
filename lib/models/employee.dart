import 'package:flutter/services.dart';

class Employee {
  int id;
  String name;
  int salary;
  int age;
  Uint8List image;

  Employee({
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
    required this.image,
  });

  factory Employee.fromMap(Map data) {
    return Employee(
      id: data['ID'],
      name: data['Name'],
      salary: data['Salary'],
      age: data['Age'],
      image: data['Image'],
    );
  }
}
