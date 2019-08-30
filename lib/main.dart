import 'package:flutter/material.dart';
import 'package:maze_generator/maze/Maze.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Maze(
        size: this.size,
        accessibleControls: this.accessibleControls,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>setState(() => size++),
        child: Icon(
          Icons.add,
        ),
      ),
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
    );
  }
}
