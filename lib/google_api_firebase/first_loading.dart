import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo_ver_2/first_screen/task_screen.dart';
import '../globals.dart' as globals;
import '../task_data_manager/task_data.dart';

class FirstLoading extends StatefulWidget {
  @override
  _FirstLoadingState createState() => _FirstLoadingState();
}

class _FirstLoadingState extends State<FirstLoading> {
  String searchingWords;
  GoogleSignInAccount currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://mail.google.com/',
    'https://www.googleapis.com/auth/gmail.modify',
    'https://www.googleapis.com/auth/gmail.readonly'
  ]);

  void googleSignIn() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser = account;
        globals.currentUser = currentUser;
      });
      if (currentUser != null) {
        _handleSignIn();
      }
    });
    if(currentUser == null){
      _googleSignIn.signIn();
    }
    await _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    if (user == null) {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: 'an email', password: 'a password'))
          .user;
    }

    print('signed in ' + user.displayName);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return TasksScreen();
    }));
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context,taskData,child){
        return Scaffold(
          body: Center(
            child: SpinKitDoubleBounce(
              color: Colors.black,
              size: 100.0,
            ),
          ),
        );
      },

    );;
  }
}
