part of 'operation_on_task_bloc.dart';

abstract class OperationOnTaskState extends Equatable {
  const OperationOnTaskState();
  
  @override
  List<Object> get props => [];
}

class OperationOnTaskInitialState extends OperationOnTaskState {}
class OperationOnTaskLoadingState extends OperationOnTaskState {}
class OperationOnTaskMessageState extends OperationOnTaskState {
  final String message;
  const OperationOnTaskMessageState({required this.message});
  @override
  List<Object> get props => [message];
}
class OperationOnTaskErrorState extends OperationOnTaskState {
  final String message;
  const OperationOnTaskErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
