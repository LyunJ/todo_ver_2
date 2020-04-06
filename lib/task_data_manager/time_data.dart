import 'package:flutter/material.dart';
import 'dart:async';
import 'task.dart';

class TimeData extends ChangeNotifier {
  DateTime selectStartDate;
  TimeOfDay selectStartTime;
  DateTime selectEndDate;
  TimeOfDay selectEndTime;

  void initTime(var time) {
    if (time.runtimeType == DateTime) {
      time = DateTime.now();
    } else if (time.runtimeType == TimeOfDay) {
      time = TimeOfDay.now();
    }
  }

  Future<DateTime> startDateSelector(BuildContext context, Task task) async {
    final DateTime pick = await showDatePicker(
      context: context,
      initialDate: task.startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pick != null) {
      task.startDate = pick;
      notifyListeners();
    }
    return pick;
  }

  Future<TimeOfDay> startTimeSelector(BuildContext context, Task task) async {
    final TimeOfDay time =
        await showTimePicker(context: context, initialTime: task.startTime);
    if (time != null) {
      task.startTime = time;
      notifyListeners();
    }
    return time;
  }

  Future<DateTime> endDateSelector(BuildContext context, Task task) async {
    final DateTime pick = await showDatePicker(
        context: context,
        initialDate: task.endDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (pick != null) {
      task.endDate = pick;
      notifyListeners();
    }
    return pick;
  }

  Future<TimeOfDay> endTimeSelector(BuildContext context, Task task) async {
    final TimeOfDay time =
        await showTimePicker(context: context, initialTime: task.endTime);
    if (time != null) {
      task.endTime = time;
      notifyListeners();
    }
    return time;
  }

  Future<DateTime> initStartDateSelector(
      BuildContext context, DateTime startDate) async {
    if (startDate == null) {
      startDate = DateTime.now();
    }
    final DateTime pick = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pick != null) {
      startDate = pick;
      notifyListeners();
    }
    return startDate;
  }

  Future<TimeOfDay> initStartTimeSelector(
      BuildContext context, TimeOfDay startTime) async {
    if (startTime == null) {
      startTime = TimeOfDay.now();
    }
    final TimeOfDay time =
        await showTimePicker(context: context, initialTime: startTime);
    if (time != null) {
      startTime = time;
      notifyListeners();
    }
    return startTime;
  }

  Future<DateTime> initEndDateSelector(
      BuildContext context, DateTime endDate) async {
    if (endDate == null) {
      endDate = DateTime.now();
    }
    final DateTime pick = await showDatePicker(
        context: context,
        initialDate: endDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
    if (pick != null) {
      endDate = pick;
      notifyListeners();
    }
    return endDate;
  }

  Future<TimeOfDay> initEndTimeSelector(
      BuildContext context, TimeOfDay endTime) async {
    if (endTime == null) {
      endTime = TimeOfDay.now();
    }
    final TimeOfDay time =
        await showTimePicker(context: context, initialTime: endTime);
    if (time != null) {
      endTime = time;
      notifyListeners();
    }
    return endTime;
  }

  double getDiffrence(TimeOfDay startTime, TimeOfDay endTime) {
    double start = startTime.hour.toDouble() +
        (startTime.minute.toDouble() / 60);
    double end =
        endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);
    double timeDiff = start - end;
    notifyListeners();
    return timeDiff * 10;
  }
}
