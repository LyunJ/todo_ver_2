import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'task.dart';
import 'dart:collection';
import '../google_api_firebase/firebaseCRUD.dart';

class TaskData extends ChangeNotifier{
  List<Task> _tasks = [
    Task(name: 'hello',priority: Colors.red,timeDiff: 100,startDate: DateTime(9999),startTime: TimeOfDay(hour: 23, minute: 59),endDate: DateTime(9999),endTime: TimeOfDay(hour: 23, minute: 59)),
  ];

  TaskData() {
    FirebaseCRUD().read(_tasks);
  }

  UnmodifiableListView<Task> get tasks{
    return UnmodifiableListView(_tasks);
  }

  int get taskCount{
    return _tasks.length;
  }

  void addTask(String newTaskTitle,double timeDiff,DateTime _startDate, TimeOfDay _startTime, DateTime _endDate, TimeOfDay _endTime, String phoneNumber, String email){
    Task task = Task(name: newTaskTitle,timeDiff: timeDiff,startTime: _startTime,startDate: _startDate,endTime: _endTime,endDate: _endDate,phoneNumber: phoneNumber,email: email);
    _tasks.add(task);
    FirebaseCRUD().create(newTaskTitle, email, phoneNumber, false, timeDiff, _startDate, _endDate, _startTime, _endTime);
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task){
    FirebaseCRUD().delete(task.name);
    _tasks.remove(task);
    notifyListeners();
  }

  void editTask(Task task, String taskTitle,double timeDiff,DateTime startDate, TimeOfDay startTime, DateTime endDate, TimeOfDay endTime, String phoneNumber, String email){
    FirebaseCRUD().edit(task.name,taskTitle, email, phoneNumber, task.isDone, timeDiff, startDate, endDate, startTime, endTime);
    task.name = taskTitle;
    task.timeDiff = timeDiff;
    task.startDate = startDate;
    task.startTime = startTime;
    task.endDate = endDate;
    task.endTime = endTime;
    task.phoneNumber = phoneNumber;
    task.email = email;
  }

  void sortTask(){
    _tasks.sort((a,b){
      double aTime = a.startTime.hour.toDouble() + (a.startTime.minute.toDouble() / 60);
      double bTime = b.startTime.hour.toDouble() + (b.startTime.minute.toDouble() / 60);
      return aTime.compareTo(bTime);
    });
    notifyListeners();
  }
}