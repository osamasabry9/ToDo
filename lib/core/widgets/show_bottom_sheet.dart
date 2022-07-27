import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/notification_services.dart';
import '../util/snackbar.dart';
import '../util/style.dart';
import 'loading_widget.dart';
import '../../features/tasks/domain/entities/task.dart';
import '../../features/tasks/presentation/bloc/operation_on_task/operation_on_task_bloc.dart';
import '../../features/tasks/presentation/bloc/tasks/tasks_bloc.dart';

class ShowBottomSheet extends StatelessWidget {
  final Tasks task;
  NotifyHelper notifyHelper = NotifyHelper();
  ShowBottomSheet({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OperationOnTaskBloc, OperationOnTaskState>(
      listener: (context, state) {
        if (state is OperationOnTaskMessageState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          Navigator.pop(context);
        } else if (state is OperationOnTaskErrorState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is OperationOnTaskLoadingState) {
          return const LoadingWidget();
        }
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 4,
            ),
            width: double.infinity,
            height: (task.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.30
                : MediaQuery.of(context).size.height * 0.39),
            color: Colors.white,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 6,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                task.isCompleted == 1
                    ? Container()
                    : _buildBottomSheet(
                        context,
                        label: 'Task Completed',
                        onTap: () => _updateTask(
                          context: context,
                          isCompleted: 1,
                          isFavorites: task.isFavorites,
                        ),
                        clr: primaryClr,
                      ),
                task.isFavorites == 1
                    ? _buildBottomSheet(
                        context,
                        label: 'Remove from favorites',
                        onTap: () => _updateTask(
                          context: context,
                          isCompleted: task.isCompleted,
                          isFavorites: 0,
                        ),
                        clr: primaryClr,
                      )
                    : _buildBottomSheet(
                        context,
                        label: 'Add to favourites ',
                        onTap: () => _updateTask(
                          context: context,
                          isCompleted: task.isCompleted,
                          isFavorites: 1,
                        ),
                        clr: primaryClr,
                      ),
                const Divider(
                  color: darkGreyClr,
                ),
                _buildBottomSheet(
                  context,
                  label: 'Delete Taske',
                  onTap: () => _deleteTask(context),
                  clr: Colors.redAccent,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _updateTask({
    required BuildContext context,
    isCompleted,
    isFavorites,
  }) {
    final taskUpdate = Tasks(
      id: task.id,
      title: task.title,
      startTime: task.startTime,
      endTime: task.endTime,
      color: task.color,
      isCompleted: isCompleted,
      date: task.date,
      isFavorites: isFavorites,
      remind: task.remind,
      repeat: task.repeat,
    );
    BlocProvider.of<OperationOnTaskBloc>(context).add(UpdateTaskEvent(
      task: taskUpdate,
    ));
    BlocProvider.of<TasksBloc>(context).add(RefreshTasksEvent());
    debugPrint(
        'Update Favorites: ${task.isFavorites} Completed: ${task.isCompleted}');
    notifyHelper.cancelNotification(task);
  }

  _deleteTask(context) {
    BlocProvider.of<OperationOnTaskBloc>(context).add(DeleteTaskEvent(
      taskId: task.id!,
    ));
    BlocProvider.of<TasksBloc>(context).add(RefreshTasksEvent());
    notifyHelper.cancelNotification(task);
  }

  _buildBottomSheet(
    BuildContext context, {
    required String label,
    required Function() onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose ? Colors.grey[300]! : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle
                : titleStyle.copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
