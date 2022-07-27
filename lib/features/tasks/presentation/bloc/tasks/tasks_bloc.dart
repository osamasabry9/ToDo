import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/strings/message_failure.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/usecases/get_tasks.dart';
import '../../../domain/usecases/initial_database.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final InitialDbUsecase initialDb;
  final GetTasksUsecase getTasks;
  TasksBloc({
    required this.initialDb,
    required this.getTasks,
  }) : super(TasksInitialState()) {
    on<TasksEvent>((event, emit) async {
      if (event is InitialDbEvent) {
        emit(TasksLoadingState());
        final result = await initialDb();
        result.fold(
          (failure) =>
              emit(TasksErrorState(message: mapFailureToMessage(failure))),
          (_) => emit(
            const TasksMessageState(message: 'Initial database secces '),
          ),
        );
      } else if (event is GetTasksEvent || event is RefreshTasksEvent) {
        emit(TasksLoadingState());
        final result = await getTasks();
        result.fold(
          (failure) =>
              emit(TasksErrorState(message: mapFailureToMessage(failure))),
          (tasks) => emit(TasksLodaedState(tasks: tasks)),
        );
      }
    });
  }
}
