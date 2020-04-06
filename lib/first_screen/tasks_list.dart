import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../list_manage_page/edit_list_page.dart';
import 'package:todo_ver_2/first_screen/submitted_tile.dart';
import '../task_data_manager/task_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: SubmittedTile(
                  taskTitle: task.name,
                  isChecked: task.isDone,
                  checkboxCallback: (checkboxState) {
                    taskData.updateTask(task);
                  },
                  tasks: task,
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: EditListPage(task: task,))),
                      );
                    },
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      taskData.deleteTask(task);
                    },
                  ),
                ]);
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
