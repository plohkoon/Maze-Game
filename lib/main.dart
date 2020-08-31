import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/AppScaffold.dart';
import 'package:maze_generator/dataFlow/ColorStream.dart';
import 'package:maze_generator/dataFlow/DarkModeStream.dart';

void main() => runApp(MazeGame());

class MazeGame extends StatefulWidget {
  MazeGame({Key key}) : super(key: key);

  @override
  _MazeGameState createState() => _MazeGameState();
}

class _MazeGameState extends State<MazeGame> {
  //initializes the state
  final String title = 'Maze Game';
  //index of color to use
  Color currentColor;
  StreamSubscription colorListener;
  bool darkMode;
  StreamSubscription darkListener;

  @override
  void initState() {
    // init streams
    currentColor = ColorStream.color;
    darkMode = DarkModeStream.darkMode;
    this.colorListener = ColorStream.makeListener((Color newColor) {
      setState(() {
        this.currentColor = newColor;
      });
    }, this.colorListener);
    this.darkListener = DarkModeStream.makeListener((bool isDark) {
      setState(() {
        this.darkMode = isDark;
      });
    }, this.darkListener);
    super.initState();
  }

  @override
  void dispose() {
    this.colorListener.cancel();
    this.darkListener.cancel();
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
        child: AppScaffold(title: title)
      ),
    );
  }
}
