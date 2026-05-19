class TaskModel {
  final int id;
  final String title;
  bool completed;
  final String category;

  TaskModel({
    required this.id,
    required this.title,
    required this.completed,
    required this.category,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      category: json['category'],
    );
  }
}
