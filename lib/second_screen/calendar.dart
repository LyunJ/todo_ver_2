import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:todo_ver_2/task_data_manager/task_data.dart';
import 'package:todo_ver_2/task_data_manager/task.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime,List<dynamic>> _events;
  CalendarController _calendarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _calendarController = CalendarController();
    _events = {};
  }

  void initEvents(TaskData taskData){
    List<Task> _task = taskData.tasks;

  }

  List<String> searchEvent(DateTime today,List<Task> task){
    List<String> eventName = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskData,child){
        initEvents(taskData);
        return TableCalendar(
          calendarController: _calendarController,
        );
      },
    );
  }
}
