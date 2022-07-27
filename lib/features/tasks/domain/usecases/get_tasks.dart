import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/task.dart';
import '../repositories/tasks_repositories.dart';

class GetTasksUsecase {
  final TasksRepositories taskRepository;
  GetTasksUsecase({required this.taskRepository});

  Future<Either<Failure, List<Tasks>>> call() async {
    return await taskRepository.getTasks();
  }
}
