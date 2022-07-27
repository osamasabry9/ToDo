import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/tasks/tasks_bloc.dart';
import '../widgets/calender_widget/date_bar.dart';
import '../widgets/calender_widget/tasks_list_widget.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _calender(),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          _addDateBar(),
          _showTasks(),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Schedule',
      ),
    );
  }

  Widget _calender() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: Colors.green,
        dateTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        dayTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        monthTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        onDateChange: (newselectedDate) {
          setState(() {
            _selectedDate = newselectedDate;
          });
        },
      ),
    );
  }

  Widget _addDateBar() {
    return const DateBar();
  }

  _showTasks() {
    return Expanded(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoadingState) {
            return const LoadingWidget();
          } else if (state is TasksLodaedState) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<TasksBloc>(context).add(RefreshTasksEvent());
              },
              child: TasksListWidget(
                tasks: state.tasks,
                selectedDate: _selectedDate,
              ),
            );
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}
