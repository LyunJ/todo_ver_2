import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ver_2/task_data_manager/time_data.dart';
import '../task_data_manager/task_data.dart';
import 'package:todo_ver_2/task_data_manager/task.dart';


class AddChart extends ChangeNotifier{
  List<Widget> chartList = [];
  List<Task> taskList = [];

  void drawChart(TaskData taskData){
    int taskLength = taskData.taskCount;
    for (int i = 0; i < taskLength; i++) {
      final tasks = taskData.tasks[i];
      AddChart().addChart(tasks,chartList);
    }
    notifyListeners();
  }

  void addChart(final tasks,List<Widget> chartList){
      chartList.add(Container(
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsets.only(right: 6,left: 2,top: 2),
        child: Text(tasks.name,textAlign: TextAlign.center,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blueGrey,width:2),
        ),
        height: 100,
        width: tasks.taskTime.toDouble() < 0 ? tasks.taskTime.toDouble() * (-1) : tasks.taskTime.toDouble(),
      ));
  }

  Widget topChart(TaskData taskData){
    drawChart(taskData);
    return Row(
      children: chartList,
    );
  }
}

class TopChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context,taskData,child){
      return Consumer<TimeData>(builder: (context,timeData,child){
        return AddChart().topChart(taskData);
      });
    });
  }
}

