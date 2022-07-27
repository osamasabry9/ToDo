import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/button.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/tasks/tasks_bloc.dart';
import 'calender_page.dart';
import 'create_task_page.dart';
import '../widgets/home/list_view_of_tasks_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: false,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Board',
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CalenderPage()),
                  );
                },
              ),
            ),
          ],
          bottom: const TabBar(
            labelPadding: EdgeInsets.only(left: 5, right: 5),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: primaryClr,
            indicatorWeight: 4,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: 'All',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Uncompleted',
              ),
              Tab(
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _showTasks(
              context: context,
              isAllTasks: true,
            ),
            _showTasks(
              context: context,
              isAllTasks: false,
              isCompletedTasks: true,
            ),
            _showTasks(
              context: context,
              isAllTasks: false,
              isUnCompletedTasks: true,
            ),
            _showTasks(
              context: context,
              isAllTasks: false,
              isFavorites: true,
            ),
          ],
        ),
      ),
    );
  }

  _showTasks({
    context,
    required bool isAllTasks,
    bool isCompletedTasks =false,
    bool isUnCompletedTasks = false,
    bool isFavorites = false,
  }) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksLoadingState) {
                return const LoadingWidget();
              } else if (state is TasksLodaedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<TasksBloc>(context)
                        .add(RefreshTasksEvent());
                  },
                  child: ListOfTasksWidget(
                    tasks: state.tasks,
                    allTasks: isAllTasks,
                    checkCompleted: isCompletedTasks ,
                    checkUnCompleted: isUnCompletedTasks,
                    checkFavorites: isFavorites,
                  ),
                );
              }
              return const LoadingWidget();
            },
          ),
        ),
        MyButton(
          lable: 'Add a Task',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateTaskPage()),
            );
          },
        ),
      ],
    );
  }
}
