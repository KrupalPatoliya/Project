class EmployeeDataBase {
  String id;
  String name;
  String email;
  String number;
  String salary;
  String designation;
  String gender;
  String pic;

  EmployeeDataBase({
    required this.pic,
    required this.id,
    required this.name,
    required this.email,
    required this.salary,
    required this.number,
    required this.gender,
    required this.designation,
  });

  factory EmployeeDataBase.fromMap({required Map data}) {
    return EmployeeDataBase(
      id: data['id'],
      pic: data['pic'],
      name: data['name'],
      email: data['email'],
      salary: data['salary'],
      number: data['number'],
      gender: data['gender'],
      designation: data['designation'],
    );
  }
}
