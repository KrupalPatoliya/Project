class ToDos {
  String id;
  String task_title;
  String task_description;
  String createDate;
  String doneDate;
  String status;


  ToDos({
    required this.id,
    required this.task_title,
    required this.task_description,
    required this.createDate,
    required this.doneDate,
    required this.status,

  });

  factory ToDos.fromMap({required Map data}) {
    return ToDos(
      id: data['id'],
      task_title: data['task_title'],
      task_description: data['task_description'],
      createDate: data['createDate'],
      doneDate: data['doneDate'],
      status: data['status'],
    );
  }
}
