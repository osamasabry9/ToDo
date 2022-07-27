import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/tasks_repositories.dart';

class InitialDbUsecase {
  final TasksRepositories taskRepository;
  InitialDbUsecase({required this.taskRepository});
  Future<Either<Failure, Unit>> call() async {
    return await taskRepository.initialDb();
  }
}
