part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();
  
  @override
  List<Object> get props => [];
}

class TasksInitialState extends TasksState {}
class TasksLoadingState extends TasksState {}
class TasksLodaedState extends TasksState {
  final List<Tasks> tasks;
  const TasksLodaedState({required this.tasks});
  @override
  List<Object> get props => [tasks];
}
class TasksMessageState extends TasksState {
  final String message;
  const TasksMessageState({required this.message});
  @override
  List<Object> get props => [message];
}
class TasksErrorState extends TasksState {
  final String message;
  const TasksErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
