import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/tasks_repositories.dart';

class DeleteTaskUsecase {
  final TasksRepositories taskRepository;
  DeleteTaskUsecase({required this.taskRepository});
  Future<Either<Failure, Unit>> call(int taskId) async {
    return await taskRepository.deleteTask(taskId);
  }
}
