import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/services/notification_services.dart';
import '../../../domain/entities/task.dart';
import '../../../../../core/widgets/show_bottom_sheet.dart';
import 'show_task_widget.dart';

class ListOfTasksWidget extends StatelessWidget {
  final List<Tasks> tasks;
  final bool allTasks;
  final bool checkCompleted;
  final bool checkUnCompleted;
  final bool checkFavorites;
  NotifyHelper notifyHelper = NotifyHelper();
  ListOfTasksWidget({
    super.key,
    required this.tasks,
    required this.allTasks,
    required this.checkCompleted,
    required this.checkUnCompleted,
    required this.checkFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        var date = DateFormat.jm().parse(task.startTime!);
        var time = DateFormat('HH:mm').format(date);
        notifyHelper.scheduledNotification(
          int.parse(time.toString().split(':')[0]),
          int.parse(time.toString().split(':')[1]),
          task,
        );
        if (allTasks) {
          return ShowTaskWidget(
              task: task, onTap: () => _showBottomSheet(context, task));
        } else if (task.isCompleted == 1 && checkCompleted) {
          return ShowTaskWidget(
              task: task, onTap: () => _showBottomSheet(context, task));
        } else if (task.isFavorites == 1 && checkFavorites) {
          return ShowTaskWidget(
              task: task, onTap: () => _showBottomSheet(context, task));
        } else if (task.isCompleted == 0 && checkUnCompleted) {
          return ShowTaskWidget(
              task: task, onTap: () => _showBottomSheet(context, task));
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
