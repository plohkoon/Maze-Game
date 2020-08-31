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
  String title;
  int page = 0;

  TabController pageController;

  _AppScaffoldState(this.title) {
    pageController = new TabController(
      vsync: this,
      length: 3
    );
  }

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
        body: TabBarView(
          controller: pageController,
          children: <Widget>[
            Home(),
            Maze.blitz(),
            Maze.timeRush()
          ],
          physics: NeverScrollableScrollPhysics(),
        ),
        //NavBar to switch between game modes and menu
        bottomNavigationBar: BottomAppBar(
          elevation: 20,
          child: TabBar(
            controller: pageController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
                text: "Home"
              ),
              Tab(
                icon: Icon(Icons.map),
                text: "Blitz"
              ),
              Tab(
                icon: Icon(Icons.playlist_add_check),
                text: "Time Rush"
              )
            ],
          )
        ),
      )
    );
  }
}