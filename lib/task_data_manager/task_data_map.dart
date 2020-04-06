import 'task_data.dart';
import 'task.dart';
class TaskDataMap{
  static Map<DateTime,List<Task>> _event = {};

  static Map<DateTime, List<Task>> get event => _event;

  void taskToEvent(TaskData taskData){
    List<Task> task = taskData.tasks;
    task.forEach((event){
      bool isAdded = false;
      _event.forEach((time,list){ //정렬하여 탐색하는 기능 필요
        if(time == event.startDate){
          list.add(event);
          isAdded = true;
        }
      });
      if(!isAdded){
        _event[event.startDate] = [event];
      }
    });
  }
}