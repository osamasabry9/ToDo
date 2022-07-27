import '../../domain/entities/task.dart';

class TaskModel extends Tasks {
  const TaskModel({
    required super.id,
    required super.title,
    required super.isCompleted,
    required super.isFavorites,
    required super.date,
    required super.startTime,
    required super.endTime,
    required super.color,
    required super.remind,
    required super.repeat,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      isFavorites: json['isFavorites'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      color: json['color'],
      remind: json['remind'],
      repeat: json['repeat'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isCompleted'] = isCompleted;
    data['isFavorites'] = isFavorites;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    return data;
  }
}
