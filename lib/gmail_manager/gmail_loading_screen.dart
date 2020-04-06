import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_ver_2/gmail_manager/gmail_list_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import '../globals.dart' as globals;

class GmailLoadingScreen extends StatefulWidget {
  final String searchingWord;
  GmailLoadingScreen({this.searchingWord});
  @override
  _GmailLoadingScreenState createState() => _GmailLoadingScreenState();
}

class _GmailLoadingScreenState extends State<GmailLoadingScreen> {
  String searchingWords;
  GoogleSignInAccount _currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchingWords = widget.searchingWord;
    _currentUser = globals.currentUser;
    handleGetMail(searchingWords);
  }

  Future<void> handleGetMail(String searchingWord) async{
    http.Response response = await http.get(
      'https://www.googleapis.com/gmail/v1/users/${_currentUser.email}/messages?q=from:$searchingWord',
      headers: await _currentUser.authHeaders,
    );
    if(response.statusCode != 200){
      print('errorCode: ${response.statusCode}');
    }
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> messageList = data['messages'];
    handleGetSelectedMail(messageList);
  }

  Future<void> handleGetSelectedMail(List<dynamic> messageLists) async{
    List<dynamic> data = [];
    for(int i = 0; i < messageLists.length ; i++){
      final http.Response response = await http.get(
        'https://www.googleapis.com/gmail/v1/users/${_currentUser.email}/messages/${messageLists[i]['id']}?format=full',
        headers: await _currentUser.authHeaders,
      );
      if(response.statusCode != 200){
        print('errorCode: ${response.statusCode}');
      }
      data.add(json.decode(response.body));
    }
    print('gmailScreenMailData : $data');
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return GmailListScreen(messageList: data,sender: searchingWords,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100.0,
        ),
      ),
    );
  }
}
//
//
//
//  Future<gMail.GmailApi> getGMailApi() async {
//    return gMail.GmailApi(await getGoogleClient());
//  }
//
//  Future<AuthClient> getGoogleClient() async {
//    return await clientViaServiceAccount(await getCredentials(), [
//      'email',
//      'https://mail.google.com/',
//      'https://www.googleapis.com/auth/gmail.modify',
//      'https://www.googleapis.com/auth/gmail.readonly'
//    ]);
//  }
//
//  Future<ServiceAccountCredentials> getCredentials() async {
//    if (credentials == null) {
//      credentials = ServiceAccountCredentials.fromJson(await rootBundle
//          .loadString('android/app/todoapp-270005-c7e7aeec11f7.json'));
//    }
//    return credentials;
//  }
//
//  Future<void> handleGetMail(String searchingWord) async {
//    gMail.GmailApi service = (await getGMailApi());
//
////    gMail.ListMessagesResponse response =
////    await service.users.messages.list('tedlee0118@gmail.com', q:"from: $searchingWord");
////
////    List<gMail.Message> messages;
////    while (response.messages != null) {
////      messages.addAll(response.messages);
////      if (response.nextPageToken != null) {
////        String pageToken = response.nextPageToken;
////        response = await service.users.messages
////            .list(_currentUser.email, q:'from:$searchingWord', pageToken: pageToken);
////      } else {
////        break;
////      }
////    }
////
////    for (gMail.Message message in messages) {
////      print(message.toString());
////    }
//  }