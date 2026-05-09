class TaskModel {
  String id;
  String title;
  String description;
  DateTime taskDate;
  bool isCompleted;
  bool isDeleted;
  DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.taskDate,
    required this.createdAt,
    this.isCompleted = false,
    this.isDeleted = false,
  });
}
