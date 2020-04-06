import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ver_2/task_data_manager/task_data.dart';
import 'package:todo_ver_2/task_data_manager/task.dart';
import 'package:todo_ver_2/globals.dart';

class WeekScreen extends StatefulWidget {
  @override
  _WeekScreenState createState() => _WeekScreenState();
}

class _WeekScreenState extends State<WeekScreen> {
  List<List<Task>> weekTaskList;
  List<Widget> chartList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weekTaskList = [];
    chartList = [];
    List<Task> day1 = [];
    List<Task> day2 = [];
    List<Task> day3 = [];
    List<Task> day4 = [];
    List<Task> day5 = [];
    List<Task> day6 = [];
    List<Task> day7 = [];
    weekTaskList.add(day1);
    weekTaskList.add(day2);
    weekTaskList.add(day3);
    weekTaskList.add(day4);
    weekTaskList.add(day5);
    weekTaskList.add(day6);
    weekTaskList.add(day7);
  }

  void checkWeek(TaskData taskData) {
    List<Task> taskList = taskData.tasks;
    int today = DateTime.now().day;
    int month = DateTime.now().month;
    for (int i = 0; i < taskList.length; i++) {
      int startDay = taskList[i].startDate.day;
      int startMonth = taskList[i].startDate.month;
      int yearForLeapYearCal = taskList[i].startDate.year;
      if (startMonth - month == 0) {
        if (startDay - today == 0) {
          weekTaskList[0].add(taskList[i]);
        } else if (startDay - today == 1) {
          weekTaskList[1].add(taskList[i]);
        } else if (startDay - today == 2) {
          weekTaskList[2].add(taskList[i]);
        } else if (startDay - today == 3) {
          weekTaskList[3].add(taskList[i]);
        } else if (startDay - today == 4) {
          weekTaskList[4].add(taskList[i]);
        } else if (startDay - today == 5) {
          weekTaskList[5].add(taskList[i]);
        } else if (startDay - today == 6) {
          weekTaskList[6].add(taskList[i]);
        }
      } else if (startMonth - month == 1) {
        if (month == 1 ||
            month == 3 ||
            month == 5 ||
            month == 7 ||
            month == 8 ||
            month == 10 ||
            month == 12) {
          if (startDay + (31 - today) == 1) {
            weekTaskList[1].add(taskList[i]);
          } else if (startDay + (31 - today) == 2) {
            weekTaskList[2].add(taskList[i]);
          } else if (startDay + (31 - today) == 3) {
            weekTaskList[3].add(taskList[i]);
          } else if (startDay + (31 - today) == 4) {
            weekTaskList[4].add(taskList[i]);
          } else if (startDay + (31 - today) == 5) {
            weekTaskList[5].add(taskList[i]);
          } else if (startDay + (31 - today) == 6) {
            weekTaskList[6].add(taskList[i]);
          }
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
          if (startDay + (30 - today) == 1) {
            weekTaskList[1].add(taskList[i]);
          } else if (startDay + (30 - today) == 2) {
            weekTaskList[2].add(taskList[i]);
          } else if (startDay + (30 - today) == 3) {
            weekTaskList[3].add(taskList[i]);
          } else if (startDay + (30 - today) == 4) {
            weekTaskList[4].add(taskList[i]);
          } else if (startDay + (30 - today) == 5) {
            weekTaskList[5].add(taskList[i]);
          } else if (startDay + (30 - today) == 6) {
            weekTaskList[6].add(taskList[i]);
          }
        } else if (month == 2) {
          if (yearForLeapYearCal % 4 == 0 && yearForLeapYearCal % 100 != 0 ||
              yearForLeapYearCal % 400 == 0) {
            if (startDay + (29 - today) == 1) {
              weekTaskList[1].add(taskList[i]);
            } else if (startDay + (29 - today) == 2) {
              weekTaskList[2].add(taskList[i]);
            } else if (startDay + (29 - today) == 3) {
              weekTaskList[3].add(taskList[i]);
            } else if (startDay + (29 - today) == 4) {
              weekTaskList[4].add(taskList[i]);
            } else if (startDay + (29 - today) == 5) {
              weekTaskList[5].add(taskList[i]);
            } else if (startDay + (29 - today) == 6) {
              weekTaskList[6].add(taskList[i]);
            }
          } else {
            if (startDay + (28 - today) == 1) {
              weekTaskList[1].add(taskList[i]);
            } else if (startDay + (28 - today) == 2) {
              weekTaskList[2].add(taskList[i]);
            } else if (startDay + (28 - today) == 3) {
              weekTaskList[3].add(taskList[i]);
            } else if (startDay + (28 - today) == 4) {
              weekTaskList[4].add(taskList[i]);
            } else if (startDay + (28 - today) == 5) {
              weekTaskList[5].add(taskList[i]);
            } else if (startDay + (28 - today) == 6) {
              weekTaskList[6].add(taskList[i]);
            }
          }
        }
      }
    }
  }

  void drawChart(List<Task> taskList, List<Widget> chart) {
    int taskLength = taskList.length;
    for (int i = 0; i < taskLength; i++) {
      final tasks = taskList[i];
      addChart(tasks, chart);
    }
  }

  void addChart(final tasks, List<Widget> chart) {
    chart.add(Container(
      child: Column(
          children: <Widget>[
        Text(formatTimeOfDay(tasks.startTime)),
        Container(
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(right: 6, left: 2, top: 2),
          child: Text(
            tasks.name,
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blueGrey, width: 2),
          ),
          height: 100,
          width: tasks.taskTime.toDouble() < 0
              ? tasks.taskTime.toDouble() * (-1)
              : tasks.taskTime.toDouble() * 1,
        ),
        Text(formatTimeOfDay(tasks.endTime)),
      ]),
    ));
  }

  Widget topChart(List<Task> taskList) {
    List<Widget> chart = [];
    drawChart(taskList, chart);
    return Row(
      children: chart,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        checkWeek(taskData);
        for (int i = 0; i < 7; i++) {
          Widget tempChart = topChart(weekTaskList[i]);
          if (tempChart != null) chartList.add(tempChart);
        }
        return ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: chartList[index],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Text(index == 0 ? 'Today' : 'Day ${index + 1}'),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      },
    );
  }
}
