import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ver_2/gmail_manager/gmail_loading_screen.dart';
import 'package:todo_ver_2/task_data_manager/task.dart';
import '../task_data_manager/time_data.dart';
import 'package:todo_ver_2/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmittedTile extends StatelessWidget{

  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallback;
  final Task tasks;

  SubmittedTile({this.isChecked,this.taskTitle,this.checkboxCallback,this.tasks});

  @override
  Widget build(BuildContext context) {
    _launchCaller(String phoneNumber) async {
      String url = "tel:$phoneNumber";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    DateTime _startDate = tasks.startDate;
    TimeOfDay _startTime = tasks.startTime;
    DateTime _endDate = tasks.endDate;
    TimeOfDay _endTime = tasks.endTime;

    return Consumer<TimeData>(builder: (context,timeData,child){
      return ExpansionTile(
          title: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Checkbox(
                    value: isChecked,
                    onChanged: checkboxCallback
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
                  child: Text(taskTitle),
                ),
              ),
            ],
          ),
          children:<Widget> [
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 15,),
                    Text('S.Date:',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
                    SizedBox(width: 10,),
                    Text(_startDate.year.toString() +'년',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                    Text(_startDate.month.toString() + '월',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                    Text(_startDate.day.toString() + '일',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                    SizedBox(width: 15,),
                    Text(formatTimeOfDay(_startTime).toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20))
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 15,),
                    Text('E.Date:',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20)),
                    SizedBox(width:10),
                    Text(_endDate.year.toString() + '년',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                    Text(_endDate.month.toString() + '월',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                    Text(_endDate.day.toString() + '일',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20)),
                    SizedBox(width: 15,),
                    Text(formatTimeOfDay(_endTime).toString(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20))
                  ],
                ),
                Container(
                  height: 70,
                  child: InkWell(
                    onTap: (){
                      _launchCaller(tasks.phoneNumber);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        Text(tasks.phoneNumber),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return GmailLoadingScreen(searchingWord: 'reviews@mp1.tripadvisor.com',);
                      }));
                    },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.email),
                      Text(tasks.email)
                    ],
                  ),
                )
              ],
            ),
          ]
      );
    });
  }
}
