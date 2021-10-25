import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_profile_flutter_app/home.dart';

bool isVisibleAllElement = false;
String dpUrl = "";
String posts = "";
String followers = "";
String following = "";
bool isPrivate = false;
bool isVerified = false;
String fullName = "";
String biography = "";
String externalUrl = "";
String user="";

void main() {
  debugPrint("main");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("MyAPp");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
