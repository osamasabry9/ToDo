part of 'operation_on_task_bloc.dart';

abstract class OperationOnTaskEvent extends Equatable {
  const OperationOnTaskEvent();

  @override
  List<Object> get props => [];
}

class CreateTaskEvent extends OperationOnTaskEvent {
  final Tasks task;
  const CreateTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends OperationOnTaskEvent {
  final Tasks task;
  const UpdateTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends OperationOnTaskEvent {
  final int taskId;
  const DeleteTaskEvent({required this.taskId});
  @override
  List<Object> get props => [taskId];
}
