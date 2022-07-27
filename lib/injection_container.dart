import 'package:get_it/get_it.dart';
import 'features/tasks/data/datasources/task_local_data_source.dart';
import 'features/tasks/data/repositories/task_repositories_impl.dart';
import 'features/tasks/domain/repositories/tasks_repositories.dart';
import 'features/tasks/domain/usecases/create_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';
import 'features/tasks/domain/usecases/initial_database.dart';
import 'features/tasks/domain/usecases/update_task.dart';
import 'features/tasks/presentation/bloc/operation_on_task/operation_on_task_bloc.dart';
import 'features/tasks/presentation/bloc/tasks/tasks_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Bloc
  sl.registerFactory(
    () => TasksBloc(
      getTasks: sl(),
      initialDb: sl(),
    ),
  );
  sl.registerFactory(() => OperationOnTaskBloc(
        createTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
      ));

  //! Usecase
  sl.registerLazySingleton(() => InitialDbUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => GetTasksUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => CreatTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => UpdateTaskUsecase(taskRepository: sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(taskRepository: sl()));

  //! Repository
  sl.registerLazySingleton<TasksRepositories>(() => TaskRepositoriesImpl(
        localDataSource: sl(),
      ));

  //! DataSource
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl());
}
