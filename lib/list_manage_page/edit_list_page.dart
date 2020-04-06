import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_data_manager/time_data.dart';
import '../task_data_manager/task_data.dart';
import '../task_data_manager/task.dart';
import 'package:todo_ver_2/globals.dart';

class EditListPage extends StatefulWidget {
  final Task task;
  EditListPage({this.task});
  @override
  _EditListPageState createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  bool isTaskFilled;
  bool isPhoneNumFilled;
  bool isEmailFilled;
  Task _task;

  TextEditingController toDoController;
  TextEditingController phoneNumController;
  TextEditingController emailController;

  DateTime startDate;
  TimeOfDay startTime;
  DateTime endDate;
  TimeOfDay endTime;

  String name;
  String phoneNumber;
  String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isTaskFilled = false;
    isPhoneNumFilled = false;
    isEmailFilled = false;
    _task = widget.task;
    toDoController = TextEditingController(text: _task.name);
    phoneNumController = TextEditingController(text: _task.phoneNumber);
    emailController = TextEditingController(text: _task.email);
    name = _task.name;
    phoneNumber = _task.phoneNumber;
    email = _task.email;
    startDate = _task.startDate;
    startTime = _task.startTime;
    endDate = _task.endDate;
    endTime = _task.endTime;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
              child: TextField(
                autofocus: true,
                controller: toDoController,
                decoration: InputDecoration(
                    errorText: isTaskFilled == false ? '필수 입력란입니다' : null,
                    hintText: '할 일을 적어주세요',
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlueAccent)
                    )
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                    if(value == ''){
                      isTaskFilled = false;
                    }else {
                      isTaskFilled = true;
                    }
                  });
                },
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('시작:'),
                          SizedBox(
                            child: FlatButton(
                                onPressed: () async{
                                  startDate = await TimeData().initStartDateSelector(
                                      context, startDate);
                                },
                                child: Icon(Icons.calendar_today)),
                            width: 50,
                            height: 50,
                          ),
                          Text(startDate.year.toString()),
                          Text(startDate.month.toString()),
                          Text(startDate.day.toString()),
                          SizedBox(
                              width: 50,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () async {
                                    startTime = await TimeData().initStartTimeSelector(
                                        context, startTime);
                                  },
                                  child: Icon(Icons.timelapse))),
                          Text(formatTimeOfDay(startTime)
                              .toString())
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('끝:'),
                          SizedBox(
                              width: 50,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () async {
                                    endDate = await TimeData().initEndDateSelector(
                                        context, endDate);
                                  },
                                  child: Icon(Icons.calendar_today))),
                          Text(endDate.year.toString()),
                          Text(endDate.month.toString()),
                          Text(endDate.day.toString()),
                          SizedBox(
                              width: 50,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () async {
                                    endTime = await TimeData().initEndTimeSelector(
                                        context, endTime);
                                  },
                                  child: Icon(Icons.timelapse))),
                          Text(formatTimeOfDay(endTime)
                              .toString())
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
                    child: Row(
                      children: <Widget>[
                        Text('PHONENUMBER:'),
                        Flexible(
                          child: TextField(
                            autofocus: true,
                            controller: phoneNumController,
                            decoration:
                            InputDecoration(hintText: '전화번호를 적어 주세요',
                            ),
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 25, 0),
                    child: Row(
                      children: <Widget>[
                        Text('E-MAIL'),
                        Flexible(
                          child: TextField(
                            controller: emailController,
                            autofocus: true,
                            decoration:
                            InputDecoration(hintText: 'E-MAIL을 적어주세요'),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                if (name == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            width: 300,
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    '빈 칸을 모두 채워주세요',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 50.0,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('i got it'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                  toDoController.clear();
                  phoneNumController.clear();
                  emailController.clear();
                } else {
                  Provider.of<TaskData>(context, listen: false).editTask(
                      _task,
                      name,
                      TimeData().getDiffrence(startTime,endTime),
                      startDate,
                      startTime,
                      endDate,
                      endTime,
                      phoneNumber == null ? '' : phoneNumber,
                      email == null ? '' : email);
                  Provider.of<TaskData>(context, listen: false).sortTask();

                  toDoController.clear();
                  phoneNumController.clear();
                  emailController.clear();

                  Navigator.pop(context);
                }
              },
              child: Text('EDIT', style: TextStyle(color: Colors.white)),
              color: Colors.lightBlueAccent,
            )
          ],
        ),
      ),
    );
  }
}
