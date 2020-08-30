import 'package:flutter/material.dart';
import 'package:maze_generator/Customizations/ToggleAccessible.dart';

import 'package:maze_generator/maze/Maze.dart';
import 'package:maze_generator/Home/Home.dart';

class AppScaffold extends StatefulWidget {
  final String title;
  AppScaffold({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppScaffoldState(this.title);
}

class _AppScaffoldState extends State<AppScaffold> with SingleTickerProviderStateMixin {
  // TODO use the fucking streams idiot
  bool accessibleControls = false;
  String title;
  int page = 0;

  _AppScaffoldState(this.title);

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        //appBar that contains the title and accessibility controls
        appBar: AppBar(
          title: Row(
            children: [
              Text(this.title),
              Expanded(child: Row()),
              //renders accessibility controls label and a switch to toggle it
              ToggleAccessible()
            ],
          ),
        ),
        //the maze is the body of the app
        body: [
          Home(),
          Maze.blitz(
            accessibleControls: this.accessibleControls,
          ),
          Maze.timeRush(
            accessibleControls: this.accessibleControls,
          )
        ][page],
        //NavBar to switch between game modes and menu
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            print(index);
            setState(() {
              page = index;
            });
          },
          currentIndex: page,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text("Blitz"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check),
              title: Text("Time Rush"),
            ),
          ],
          // TODO why is this not off of the theme?
          backgroundColor: Colors.blueGrey[800],
          unselectedItemColor: Colors.blueGrey[300],
        ),
      )
    );
  }
}