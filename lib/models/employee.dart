import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
      id: data['id'],
      name: data['name'],
      salary: data['salary'],
      age: data['age'],
      image: data['image'],
    );
  }
}
