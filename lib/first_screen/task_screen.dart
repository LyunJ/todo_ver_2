import 'package:flutter/material.dart';
import 'package:todo_ver_2/first_screen/tasks_list.dart';
import 'package:todo_ver_2/second_screen/calendar.dart';
import 'package:todo_ver_2/week_screen/week_screen.dart';
import 'top_chart.dart';
import '../list_manage_page/add_list_page.dart';
import '../second_screen/calendar.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _selectedIndex;
  List<Widget> bottomNavigationWigets = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
    bottomNavigationWigets.add(Column(
      children: <Widget>[
        TopChart(),
        Expanded(
          child: TaskList(),
        ),
      ],
    ));
    bottomNavigationWigets.add(WeekScreen());
    bottomNavigationWigets.add(CalendarPage());
  }
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index){
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddListPage(),
            ),
          ));
        },
      ),
      appBar: AppBar(
        title: Text('toDoList'),
        backgroundColor: Colors.teal,
      ),
      body: bottomNavigationWigets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one),
            title: Text('Day'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_week),
            title: Text('Week'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day),
            title: Text('Month'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}