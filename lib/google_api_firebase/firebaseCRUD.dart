import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../task_data_manager/task.dart';
import 'package:todo_ver_2/globals.dart';

class FirebaseCRUD {
  Firestore firestore = Firestore.instance;

  void create(
      String name,
      String email,
      String phoneNumber,
      bool isDone,
      double timeDiff,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay startTime,
      TimeOfDay endTime) {

    Map<String, dynamic> temp = {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isDone': isDone,
      'timeDiff': timeDiff,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'startTime': timeToDate(startTime),
      'endTime': timeToDate(endTime)
    };
    firestore.collection('Task').document(startDate.toString()).setData({
      'task' : temp
    });

  }

  void delete(DateTime time) {
    firestore.collection('Task').document(time.toString()).delete();
  }

  void edit(
      DateTime time,
      String name,
      String email,
      String phoneNumber,
      bool isDone,
      double timeDiff,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay startTime,
      TimeOfDay endTime) {

    Map<String, dynamic> temp = {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isDone': isDone,
      'timeDiff': timeDiff,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
      'startTime': timeToDate(startTime),
      'endTime': timeToDate(endTime)
    };
    firestore.collection('Task').document(time.toString()).updateData({
      'task' : temp
    });
  }

  Future<void> read(List<Task> task) async {
    await firestore
        .collection('Task')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((doc) => task.add(Task(
          name: doc.data['name'],
          priority: Colors.blue,
          timeDiff: doc.data['timeDiff'],
          startDate: dateFormat(doc.data['startDate']),
          startTime: timeFormat(doc.data['startTime']),
          endDate: dateFormat(doc.data['endDate']),
          endTime: timeFormat(doc.data['endTime']),
          phoneNumber: doc.data['phoneNumber'],
          email: doc.data['email'])));
    });
  }
}
