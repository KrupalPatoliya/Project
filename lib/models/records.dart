class Records {
  int? id;
  String path;

  Records({required this.path, this.id});

  factory Records.fromMap({required Map data}) {
    return Records(id: data["ID"], path: data["path"]);
  }
}
