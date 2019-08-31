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

  void triggerWin() {
    setState(() {
      this.size++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(this.title),
            Expanded(child: Row(),),
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
      body: Maze(
        size: this.size,
        accessibleControls: this.accessibleControls,
        triggerWin: this.triggerWin,
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
