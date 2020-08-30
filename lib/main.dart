import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/AppScaffold.dart';
import 'package:maze_generator/dataFlow/AccessibleStream.dart';
import 'package:maze_generator/dataFlow/ColorStream.dart';
import 'package:maze_generator/dataFlow/DarkModeStream.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(
      title: "Maze Game"
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.title);
}

class _MyHomePageState extends State<MyHomePage> {
  //initializes the state
  final String title;
  //index of color to use
  Color currentColor;
  StreamSubscription colorListener;
  bool accessibleControls;
  StreamSubscription accessibleListener;
  bool darkMode;
  StreamSubscription darkListener;

  TabController pageController;
  //constructor
   _MyHomePageState(this.title) {
     currentColor = ColorStream.color;
     darkMode = DarkModeStream.darkMode;
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      //theme data toggles with dark mode toggle
      theme: this.darkMode ?
      ThemeData (
        primarySwatch: this.currentColor,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        textTheme: Typography.whiteMountainView
      ) :
      ThemeData(
        primarySwatch: this.currentColor,
        scaffoldBackgroundColor: Colors.blueGrey[200],
        textTheme: Typography.blackMountainView
      ),
      home: SafeArea(
        child: AppScaffold()
      ),
    );
  }
}
