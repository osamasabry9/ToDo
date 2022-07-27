import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/notification_services.dart';
import 'core/util/style.dart';
import 'features/tasks/data/datasources/task_local_data_source.dart';
import 'features/tasks/presentation/bloc/operation_on_task/operation_on_task_bloc.dart';
import 'features/tasks/presentation/bloc/tasks/tasks_bloc.dart';
import 'features/tasks/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await TaskLocalDataSourceImpl.inttDb();
  runApp(const MyApp());
  NotifyHelper().initializeNotification();
  NotifyHelper().requestIOSPermissions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<TasksBloc>()
            ..add(InitialDbEvent())
            ..add(GetTasksEvent()),
        ),
        BlocProvider<OperationOnTaskBloc>(
          create: (context) => di.sl<OperationOnTaskBloc>(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes.theme,
          home: const HomePage()),
    );
  }
}
