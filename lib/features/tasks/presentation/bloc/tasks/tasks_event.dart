part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}
class GetTasksEvent extends TasksEvent {}
class InitialDbEvent extends TasksEvent {}
class RefreshTasksEvent extends TasksEvent {}
