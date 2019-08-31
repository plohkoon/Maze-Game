import 'package:flutter/material.dart';
import 'package:maze_generator/maze/Maze.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maze Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
      ),
      home: MyHomePage(title: 'Maze Game'),
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
  int size = 5;
  bool accessibleControls = false;
  final String title;
  //constructor
   _MyHomePageState(this.title);
  //function to trigger win, at the moment just ups the size of the maze and regenerates
  void triggerWin() {
    setState(() {
      this.size++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    onChanged: (bool newVal) => {
                      setState(() {
                        this.accessibleControls = !this.accessibleControls;
                      }),
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        //the maze is the body of the app
        body: Maze(
          size: this.size,
          accessibleControls: this.accessibleControls,
          triggerWin: this.triggerWin,
        ),
        //just a test FAB that tests the maze resizing
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>setState(() => size++),
          child: Icon(
            Icons.add,
          ),
        ),
        //will eventually be a navBar to switch between modes
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () => print("home"),
              ),
              IconButton(
                icon: Icon(Icons.map),
                onPressed: () => print("maze1"),
              )
            ],
          )
        ),
      )
    );
  }
}
