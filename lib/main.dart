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

  int page = 0;
  //constructor
   _MyHomePageState(this.title);
  //function to trigger win, at the moment just ups the size of the maze and regenerates
  void triggerWin() {
    print("player won this one");
    print(this.size.toString());
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

  Widget _generateHome() {
    return Text("Home");
  }
  Widget _generateBlitz() {
    this.size = 5;
    return Maze(
            size: this.size,
            accessibleControls: this.accessibleControls,
            triggerWin: this.triggerWin,
          );
  }
  Widget _generateTimeRush() {
    return Text("Time Rush");
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
          body: [
            Text("Home"),
            Maze(
              size: this.size,
              accessibleControls: this.accessibleControls,
              triggerWin: this.triggerWin,
            ),
            Text("Time Rush")
          ][page],
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
          ),
        ),
      ),
    );
  }
}
