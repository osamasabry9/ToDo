import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/task.dart';
import '../../../../../core/widgets/show_bottom_sheet.dart';
import 'task_tilte_widget.dart';

class TasksListWidget extends StatelessWidget {
  final List<Tasks> tasks;
  final DateTime selectedDate;
  TasksListWidget({super.key, required this.tasks, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        if (task.repeat == 'Daily' ||
            task.date == DateFormat.yMd().format(selectedDate) ||
            (task.repeat == 'Weekly' &&
                selectedDate
                            .difference(DateFormat.yMd().parse(task.date!))
                            .inDays %
                        7 ==
                    0) ||
            (task.repeat == 'Monthly' &&
                DateFormat.yMd().parse(task.date!).day == selectedDate.day)) {
          return GestureDetector(
            onTap: () => _showBottomSheet(context, task),
            child: TaskTitle(task: task),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _showBottomSheet(BuildContext context, Tasks task) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShowBottomSheet(task: task),
    );
  }
}
