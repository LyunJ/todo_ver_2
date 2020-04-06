import 'package:flutter/material.dart';

class Task {
  String name;
  bool isDone;
  double timeDiff;
  TimeOfDay startTime;
  TimeOfDay endTime;
  DateTime startDate;
  DateTime endDate;
  String phoneNumber;
  String email;
  Color priority;

  Task(
      {this.name = '',
      this.isDone = false,
      this.priority = Colors.amber,
      this.timeDiff = 100,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.phoneNumber = '',
      this.email = ''});

  void toggleDone() {
    isDone = !isDone;
  }

  double get taskTime {
    return timeDiff;
  }

  Color get taskPriority {
    return priority;
  }

}
