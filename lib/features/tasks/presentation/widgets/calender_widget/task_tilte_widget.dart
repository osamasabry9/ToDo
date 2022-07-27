import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/style.dart';
import '../../../domain/entities/task.dart';
import '../../bloc/tasks/tasks_bloc.dart';

class TaskTitle extends StatelessWidget {
  final Tasks task;
  const TaskTitle({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          width: size.width,
          margin: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _getBGClr(task.color) ?? primaryClr),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey[200],
                              size: 18,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              '${task.startTime}  -  ${task.endTime}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          task.title!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  task.isCompleted == 1
                      ? Icons.check_circle_outline_outlined
                      : Icons.circle_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return bluishClr;
    }
  }
}
