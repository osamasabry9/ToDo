import '../../../../core/error/exception.dart';
import '../datasources/task_local_data_source.dart';
import '../models/task_model.dart';
import '../../domain/entities/task.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/tasks_repositories.dart';

class TaskRepositoriesImpl implements TasksRepositories {
  final TaskLocalDataSource localDataSource;

  TaskRepositoriesImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Unit>> initialDb() async {
    return await _getMessage(() => localDataSource.initialDb());
  }

  @override
  Future<Either<Failure, List<Tasks>>> getTasks() async {
    if (TaskLocalDataSourceImpl.db != null) {
      try {
        final result = await localDataSource.getTasks();
        return Right(result);
      } on DataBaseException {
        return Left(DataBaseFailure());
      }
    } else {
      return Left(EmptyDataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createTask(Tasks task) async {
    final TaskModel taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
      isFavorites: task.isFavorites,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      color: task.color,
      remind: task.remind,
      repeat: task.repeat,
    );
    return await _getMessage(() => localDataSource.createTask(taskModel));
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int id) async {
    return await _getMessage(() => localDataSource.deleteTask(id));
  }

  @override
  Future<Either<Failure, Unit>> updateTask(Tasks task) async {
    final TaskModel taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
      isFavorites: task.isFavorites,
      date: task.date,
      startTime: task.startTime,
      endTime: task.endTime,
      color: task.color,
      remind: task.remind,
      repeat: task.repeat,
    );
    return await _getMessage(() => localDataSource.updateTask(taskModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
    Future<Unit> Function() operation,
  ) async {
    if (TaskLocalDataSourceImpl.db != null) {
      try {
        await operation();
        return const Right(unit);
      } on DataBaseException {
        return Left(DataBaseFailure());
      }
    } else {
      return Left(EmptyDataBaseFailure());
    }
  }
}
