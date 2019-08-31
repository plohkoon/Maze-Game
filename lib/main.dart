import 'package:flutter/material.dart';
import 'package:maze_generator/maze/Maze.dart';

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
  int size = 5;
  bool accessibleControls = false;
  bool darkMode = false;
  final String title;
  //constructor
   _MyHomePageState(this.title);
  //function to trigger win, at the moment just ups the size of the maze and regenerates
  void triggerWin() {
    setState(() {
      this.size++;
    });
  }
  //function for the FAB to toggle darkmode
  void toggleDarkMode() {
    setState(() {
      this.darkMode = !this.darkMode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      //theme data toggles with dark mode toggle
      theme: darkMode ? 
        ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.black
        ):
        ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.red,
        ),
      home: SafeArea(
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
          body: Maze(
            size: this.size,
            accessibleControls: this.accessibleControls,
            triggerWin: this.triggerWin,
          ),
          //FAB to change from light to dark mode
          floatingActionButton: FloatingActionButton(
            //passes the function
            onPressed: this.toggleDarkMode,
            //changes the icon depending on if we are in dark mode
            child: this.darkMode ?
            Icon(
              Icons.brightness_3
            ):
            Icon(
              Icons.brightness_5,
            ),
          ),
          //will eventually be a navBar to switch between modes
          bottomNavigationBar: BottomAppBar(
            child: Row(
              //equally spacing the buttons on the navBar for navigation
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () => print("home"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () => print("maze1"),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.playlist_add_check),
                    onPressed: () => print("maze2"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
