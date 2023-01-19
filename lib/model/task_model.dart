class TaskModel {
  int? id;
  String title;
  String date;
  String time;
  String status;

  TaskModel({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'date': this.date,
      'time': this.time,
      'status': this.status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      time: map['time'],
      status: map['status'],
    );
  }
}
