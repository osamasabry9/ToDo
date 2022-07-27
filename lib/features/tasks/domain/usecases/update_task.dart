import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';
import '../repositories/tasks_repositories.dart';

class UpdateTaskUsecase {
  final TasksRepositories taskRepository;
  UpdateTaskUsecase({required this.taskRepository});
  Future<Either<Failure, Unit>> call(Tasks task) async {
    return await taskRepository.updateTask(task);
  }
}
