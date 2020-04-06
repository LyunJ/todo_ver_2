import 'package:flutter/material.dart';
import 'package:todo_ver_2/google_api_firebase/first_loading.dart';
import 'package:todo_ver_2/first_screen/task_screen.dart';
import 'task_data_manager/task_data.dart';
import 'package:provider/provider.dart';
import 'task_data_manager/time_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (context) => TaskData()),ChangeNotifierProvider(create: (context) => TimeData(),)],
        child: MaterialApp(
        home: FirstLoading(),
      ),
    );
  }
}

