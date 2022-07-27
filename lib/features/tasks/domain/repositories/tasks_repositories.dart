import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';

abstract class TasksRepositories {
  Future<Either<Failure, Unit>> initialDb();
  Future<Either<Failure, List<Tasks>>> getTasks();
  Future<Either<Failure, Unit>> createTask(Tasks task);
  Future<Either<Failure, Unit>> updateTask(Tasks task);
  Future<Either<Failure, Unit>> deleteTask(int id);
}
