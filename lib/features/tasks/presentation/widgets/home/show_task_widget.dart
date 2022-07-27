import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/style.dart';
import '../../../domain/entities/task.dart';
import '../../bloc/tasks/tasks_bloc.dart';

class ShowTaskWidget extends StatelessWidget {
  final Tasks task;
  final VoidCallback onTap;
  const ShowTaskWidget({required this.task, Key? key, required this.onTap})
      : super(key: key);

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
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: task.isCompleted == 1
                    ? Icon(
                        Icons.check_box,
                        color: _getBGClr(task.color) ?? primaryClr,
                        size: 30,
                      )
                    : Icon(Icons.check_box_outline_blank_rounded,
                        color: _getBGClr(task.color) ?? primaryClr, size: 30),
              ),
              Expanded(
                child: Text(
                  task.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                  onPressed: () => onTap(),
                  icon: const Icon(Icons.more_vert_rounded,
                      color: Colors.grey, size: 25)),
            ],
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
