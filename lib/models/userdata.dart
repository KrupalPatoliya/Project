class UserData {
  String gender;
  String name;
  String email;
  String picture;

  UserData({required this.gender, required this.name, required this.email, required this.picture});

  factory UserData.fromMap({required Map data}) {
    return UserData(
      gender: data['gender'],
      name: data['name']['first'] + " " + data['name']['last'],
      email: data['email'],
      picture: data['picture']['large'],
    );
  }
}
