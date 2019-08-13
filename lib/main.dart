import 'package:flutter/material.dart';
import 'package:maze_generator/Tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List<Map<String, bool>> values = [
    //single entrances
    {"up": true, "down": false, "left": false, "right": false},
    /*{"up": false, "down": true, "left": false, "right": false},
    {"up": false, "down": false, "left": true, "right": false},
    {"up": false, "down": false, "left": false, "right": true},
    //double entrances
    {"up": true, "down": true, "left": false, "right": false},
    {"up": true, "down": false, "left": true, "right": false},
    {"up": true, "down": false, "left": false, "right": true},
    {"up": false, "down": true, "left": true, "right": false},
    {"up": false, "down": true, "left": false, "right": true},
    {"up": false, "down": false, "left": true, "right": true},
    //triple entrances
    {"up": true, "down": true, "left": true, "right": false},
    {"up": true, "down": true, "left": false, "right": true},
    {"up": true, "down": false, "left": true, "right": true},
    {"up": false, "down": true, "left": true, "right": true},
    //quadruple entrances
    {"up": true, "down": true, "left": true, "right": true},*/
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState(values);
}

class _MyHomePageState extends State<MyHomePage> {
   final List<Map<String, bool>> value;
   _MyHomePageState(this.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maze Game"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: value.map((dir) => Tile(directions: dir)).toList()
      ),
    );
  }
}
