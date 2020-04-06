import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class GmailMailScreen extends StatefulWidget {
  dynamic message;

  GmailMailScreen({this.message});

  @override
  _GmailMailScreenState createState() => _GmailMailScreenState();
}

class _GmailMailScreenState extends State<GmailMailScreen> {
  dynamic messages;
  String mailBody;
  String subject;
  String date;
  String sender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messages = widget.message;
    mailBody =
        utf8.decode(Base64Codec().decode(messages['payload']['body']['data']));
    getMailBasicData(messages);
  }

  void getMailBasicData(dynamic messages) {
    dynamic tempMessage = messages['payload']['headers'];
    for (int i = 0; i < tempMessage.length; i++) {
      if (tempMessage[i]['name'] == 'Subject')
        subject = tempMessage[i]['value'];
      if (tempMessage[i]['name'] == 'Date') date = tempMessage[i]['value'];
      if (tempMessage[i]['name'] == 'From') sender = tempMessage[i]['value'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( //원하는 appbar 높이 조절
        preferredSize: Size.fromHeight(50.0),
          child: AppBar(title: Text(sender))),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white70,Colors.redAccent]
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    subject,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(date,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.right),
                ],
              ),
            ),
            Html(
              data: mailBody,
            )
          ],
        ),
      ),
    );
  }
}
