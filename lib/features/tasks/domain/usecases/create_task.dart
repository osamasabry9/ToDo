import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';
import '../repositories/tasks_repositories.dart';

class CreatTaskUsecase {
  final TasksRepositories taskRepository;
  CreatTaskUsecase({required this.taskRepository});
  Future<Either<Failure, Unit>> call(Tasks task) async {
    return await taskRepository.createTask(task);
  }
}
