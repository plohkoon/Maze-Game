import 'package:flutter/material.dart';

import 'package:maze_generator/maze/Maze.dart';
import 'package:maze_generator/Home/Home.dart';

class AppScaffold extends StatefulWidget {
  AppScaffold({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> with SingleTickerProviderStateMixin {
  // TODO use the fucking streams idiot
  bool accessibleControls = false;
  bool darkMode = false;
  String title = 'test';
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        //appBar that contains the title and accessibility controls
        appBar: AppBar(
          title: Row(
            children: [
              Text(this.title),
              Expanded(child: Row(),),
              //renders accessibility controls label and a switch to toggle it
              Row(
                children: [
                  Text("Accessibility Controls"),
                  Switch(
                    value: accessibleControls,
                    onChanged: (bool newVal) {
                      setState(() {
                        this.accessibleControls = !this.accessibleControls;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        //the maze is the body of the app
        body: [
          Home(
            currentColor: 0,
            setColor: (bool temp) {},
            darkMode: this.darkMode,
            setDark: (bool temp) {}
          ),
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
          backgroundColor: this.darkMode ? Colors.blueGrey[800] : null,
          unselectedItemColor: this.darkMode ? Colors.blueGrey[300] : Colors.blueGrey[800],
        ),
      )
    );
  }
}