import 'package:equatable/equatable.dart';

class Tasks extends Equatable {
  final int? id;
  final String? title;
  final int? isCompleted;
  final int? isFavorites;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? color;
  final int? remind;
  final String? repeat;

  const Tasks({
    this.id,
    required this.title,
    required this.isCompleted,
    required this.isFavorites,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        isCompleted,
        isFavorites,
        date,
        startTime,
        endTime,
        color,
        remind,
        repeat,
      ];
}
