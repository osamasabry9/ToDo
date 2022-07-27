import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/util/snackbar.dart';
import '../../../../core/util/style.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/task.dart';
import '../bloc/operation_on_task/operation_on_task_bloc.dart';
import '../../../../core/widgets/button.dart';
import '../bloc/tasks/tasks_bloc.dart';
import 'home_page.dart';
import '../widgets/creata_task_widget/input_field.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 20)))
      .toString();
  int _selectedRemind = 10;
  List<int> remindList = [
    10,
    30,
    60,
    1440,
  ];
  String _selectedRepeat = 'Never';
  List<String> repeatList = [
    'Never',
    'Daily',
    'Weekly',
    'Monthly',
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocConsumer<OperationOnTaskBloc, OperationOnTaskState>(
        listener: (context, state) {
          if (state is OperationOnTaskMessageState) {
            SnackBarMessage()
                .showSuccessSnackBar(context: context, message: state.message);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false);
            BlocProvider.of<TasksBloc>(context).add(RefreshTasksEvent());
          } else if (state is OperationOnTaskErrorState) {
            SnackBarMessage()
                .showErrorSnackBar(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is OperationOnTaskLoadingState) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  InputField(
                    title: 'Title',
                    hint: 'Enter title',
                    controller: _titleController,
                  ),
                  InputField(
                    title: 'Date',
                    hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                      onPressed: () => _getDateFromUser(),
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          hint: _startTime,
                          title: 'Strat Time',
                          widget: IconButton(
                            onPressed: () =>
                                _getTimeFromUser(isStartTime: true),
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          hint: _endTime,
                          title: 'End Time',
                          widget: IconButton(
                            onPressed: () =>
                                _getTimeFromUser(isStartTime: false),
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    hint: _selectedRemind > 60
                        ? '1 day early'
                        : _selectedRemind == 60
                            ? '1 hour early'
                            : '$_selectedRemind minutes early',
                    title: 'Remind',
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          items: remindList
                              .map<DropdownMenuItem<String>>(
                                (int value) => DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    value == 60
                                        ? '1 hour'
                                        : value == 1440
                                            ? '1 day'
                                            : ' minutes',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          elevation: 4,
                          iconSize: 32,
                          underline: Container(
                            height: 0,
                          ),
                          style: subTitleStyle,
                          onChanged: (String? newvalue) {
                            setState(() {
                              _selectedRemind = int.parse(newvalue!);
                            });
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  InputField(
                    hint: _selectedRepeat,
                    title: 'Repeat',
                    widget: Row(
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          items: repeatList
                              .map(
                                (value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          elevation: 4,
                          iconSize: 32,
                          underline: Container(
                            height: 0,
                          ),
                          style: subTitleStyle,
                          onChanged: (String? newvalue) {
                            setState(() {
                              _selectedRepeat = newvalue!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                        child: _colorPalette(),
                      ),
                    ],
                  ),
                  MyButton(
                    lable: 'Create Task',
                    onTap: () {
                      _validateDate();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Add Task',
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isNotEmpty) {
      _createTask();
      print('################# SOMETHING add ##########');
    } else if (_titleController.text.isEmpty) {
      SnackBarMessage().showErrorSnackBar(
          message: 'Required All fields are required! ', context: context);
    } else {
      print('################# SOMETHING BAD ##########');
    }
  }

  _createTask() async {
    final task = Tasks(
      title: _titleController.text,
      isCompleted: 0,
      isFavorites: 0,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      color: _selectedColor,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
    );
    BlocProvider.of<OperationOnTaskBloc>(context)
        .add(CreateTaskEvent(task: task));
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: CircleAvatar(
                  backgroundColor: (index == 0
                      ? bluishClr
                      : index == 1
                          ? pinkClr
                          : orangeClr),
                  radius: 16,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      SnackBarMessage().showErrorSnackBar(
          message: 'Required All fields are required! ', context: context);
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String _formatttedTime = _pickedTime!.format(context);
    if (isStartTime) {
      setState(() {
        _startTime = _formatttedTime;
      });
    } else if (!isStartTime) {
      setState(() {
        _endTime = _formatttedTime;
      });
    } else {
      print('time Canceld');
    }
  }
}
