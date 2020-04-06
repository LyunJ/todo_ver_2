import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gmail_mail_screen.dart';

class GmailListScreen extends StatefulWidget {
  final List<dynamic> messageList;
  String sender;
  GmailListScreen({this.messageList,this.sender});
  @override
  _GmailListScreenState createState() => _GmailListScreenState();
}

class _GmailListScreenState extends State<GmailListScreen> {
  List<dynamic> messageLists;
  String sender;

  Future<void> waitMessageList() async {
    messageLists = widget.messageList;
    sender = widget.sender;
    print('gmailScreenData : $messageLists');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitMessageList();
  }


  @override
  Widget build(BuildContext context) {
    String getMailSubject(dynamic messages) {
      dynamic tempMessage = messages['payload']['headers'];
      for (int i = 0; i < tempMessage.length; i++) {
        if (tempMessage[i]['name'] == 'Subject')
          return tempMessage[i]['value']; 
      }
      return '';
    }
    String getMailDate(dynamic messages) {
      dynamic tempMessage = messages['payload']['headers'];
      for (int i = 0; i < tempMessage.length; i++) {
        if (tempMessage[i]['name'] == 'Date') return tempMessage[i]['value'];
      }
      return '';
    }
    String getMailSender(dynamic messages) {
      dynamic tempMessage = messages['payload']['headers'];
      for (int i = 0; i < tempMessage.length; i++) {
        if (tempMessage[i]['name'] == 'From') return tempMessage[i]['value'];
      }
      return '';
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(sender+'\'s mail'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          dynamic message = messageLists[index];
          return ListTile(
            contentPadding: EdgeInsets.all(5),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GmailMailScreen(
                  message: message,
                );
              }));
            },
            title: Text(getMailSubject(message),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
            subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 3,),
                  Text(getMailDate(message),textAlign: TextAlign.right,style: TextStyle(fontWeight: FontWeight.w500),),
                  SizedBox(height: 5,),
                  Text(message['snippet'],maxLines: 2,)
                ],),
          );
        },
        itemCount: messageLists.length,
      ),
    );
  }
}
