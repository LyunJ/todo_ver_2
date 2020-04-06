import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
GoogleSignInAccount currentUser;

DateTime dateFormat(String string){
  return DateTime.parse(string);
}
TimeOfDay timeFormat(String tod) {
  final format = DateFormat.jm();
  return TimeOfDay.fromDateTime(format.parse(tod));
}
String timeToDate(TimeOfDay time){
  final now = DateTime.now();
  final dt = DateTime(now.year,now.month,now.day,time.hour,time.minute);
  final format = DateFormat.jm();
  return format.format(dt).toString();
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}