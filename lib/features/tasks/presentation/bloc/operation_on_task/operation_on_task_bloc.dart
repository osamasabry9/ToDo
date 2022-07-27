import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/message_failure.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/usecases/create_task.dart';
import '../../../domain/usecases/delete_task.dart';
import '../../../domain/usecases/update_task.dart';

part 'operation_on_task_event.dart';
part 'operation_on_task_state.dart';

class OperationOnTaskBloc
    extends Bloc<OperationOnTaskEvent, OperationOnTaskState> {
  final CreatTaskUsecase createTask;
  final UpdateTaskUsecase updateTask;
  final DeleteTaskUsecase deleteTask;

  OperationOnTaskBloc({
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(OperationOnTaskInitialState()) {
    on<OperationOnTaskEvent>((event, emit) async {
      if (event is CreateTaskEvent) {
        print('CreateTaskEvent called');
        emit(OperationOnTaskLoadingState());
        final result = await createTask( event.task);
        print('result: $result');
        emit(_mapFailureToState(result, ' create task Success'));
      } else if (event is UpdateTaskEvent) {
        print('UpdateTaskEvent called');
        emit(OperationOnTaskLoadingState());
        final result = await updateTask( event.task);
        emit(_mapFailureToState(result, ' Update task Success'));
      }else if (event is DeleteTaskEvent) {
        print('DeleteTaskEvent called');
        emit(OperationOnTaskLoadingState());
        final result = await deleteTask( event.taskId);
        emit(_mapFailureToState(result, ' Delete task Success'));
      }
    });
  }

  OperationOnTaskState _mapFailureToState(
    Either<Failure, Unit> result,
    String message,
  )
  {
    return result.fold(
      (failure) => OperationOnTaskErrorState(message: mapFailureToMessage(failure)),
      (_) => OperationOnTaskMessageState(message: message),
    );
  }
}
