import 'package:flutter/material.dart';
import 'package:maze_generator/tile/Tile.dart';
import 'package:maze_generator/maze/MazeGenerators.dart';
import 'dart:math' as Math;

class Maze extends StatefulWidget {

  Maze({Key key, this.size, this.accessibleControls}): super(key: key);

  final int size;
  final bool accessibleControls;

  @override
  _MazeState createState() => _MazeState(size, accessibleControls);
}

class _MazeState extends State<Maze> {
  //holder for the maze and moves
  List<Map<String, bool>> maze;
  //keeps track of the square size and the in and out
  int size;
  int entrance;
  int exit;
  //tracks the current tile we are in
  int currentTile;
  //tracks the start and current x positions of the current swipe
  double xStart;
  double yStart;
  double xCurrent;
  double yCurrent;
  //tracks whether accesible controls or not
  bool accessibleControls;
  //a constant reference to a randomizer
  Math.Random randomizer = new Math.Random();
  //constructor
  _MazeState(this.size, this.accessibleControls);
  //generates the initial maze
  @override
  void initState() {
    this._generateMaze();
    super.initState();
  }
  //when the size updates updates the internal size
  @override
  void didUpdateWidget(Maze oldMaze) {
    //if size changes updates maze
    if(oldMaze.size != this.widget.size) {
      this.size = this.widget.size;
      this._generateMaze();
    }
    this.accessibleControls = this.widget.accessibleControls;
    super.didUpdateWidget(oldMaze);
  }
  //fucntion to generate the maze, grab current tile, and start/stop
  void _generateMaze() {
    //generates the maze
    List<Map<String, bool>> maze = MazeGenerators.recursiveBacktrack(this.size);
    //generates the entrance and exit position in top and bottom rows
    int start = randomizer.nextInt(this.size);
    int end = maze.length - 1 - randomizer.nextInt(this.size);
    //opens the walls at entrance and exit
    maze[start]["up"] = true;
    maze[start]["moveUp"] = true;
    maze[end]["down"] = true;
    //sets the in and out class variables
    this.entrance = start;
    this.currentTile = start;
    this.exit = end;
    //sets the maze
    this.maze = maze;
  }
  //records the inital position of the swipe
  void handleSwipeStart(DragStartDetails details) {
    this.xStart = details.localPosition.dx;
    this.yStart = details.localPosition.dy;
  }
  //records the updated position of the swipe
  void handleSwipeUpdate(DragUpdateDetails details) {
    //grabs the current coordinates
    this.xCurrent = details.localPosition.dx;
    this.yCurrent = details.localPosition.dy;
    //grabs the direction and magnitude in the x and y directions
    double deltaX = this.xCurrent - this.xStart;
    double deltaY = this.yCurrent - this.yStart;
    print(context.size.width.toString() + ', ' + context.size.height.toString());
    //is not using accessible controls every 0.1 width worth of the maze swiped results in a move on the maze
    if(!this.accessibleControls && (deltaX.abs() > context.size.width * 0.1 || deltaY.abs() > context.size.width * 0.1)) {
      //if the swipe is more in the x direction
      if(deltaX.abs() > deltaY.abs()) {
        //if the swipe's x is greater than 0 it is to the right
        if(deltaX > 0 && maze[this.currentTile]["right"]) {
          print("right");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveRight"] = !maze[this.currentTile]["moveRight"];
            this.currentTile++;
            maze[this.currentTile]["moveLeft"] = !maze[this.currentTile]["moveLeft"];
          });
          print(maze[this.currentTile]["moveLeft"]);
        }
        //if the swipe's x is less than 0 it is to the left
        else if(deltaX < 0 && maze[this.currentTile]["left"]) {
          print("left");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveLeft"] = !maze[this.currentTile]["moveLeft"];
            this.currentTile--;
            maze[this.currentTile]["moveRight"] = !maze[this.currentTile]["moveRight"];
          });
          print(maze[this.currentTile]["moveRight"]);
        }
      }
      //if the swipe is more in the y direction
      else {
        //the swipes y is greater than 0 is is moving top down
        if(deltaY > 0 && maze[this.currentTile]["down"]) {
          print("down");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveDown"] = !maze[this.currentTile]["moveDown"];
            this.currentTile += this.size;
            maze[this.currentTile]["moveUp"] = !maze[this.currentTile]["moveUp"];
          });
          print(maze[this.currentTile]["moveUp"]);
        }
        //the swipes y is less than 0 is moving bottom up
        else if(deltaY < 0 && maze[this.currentTile]["up"] && this.currentTile != this.entrance) {
          print("up");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveUp"] = !maze[this.currentTile]["moveUp"];
            this.currentTile -= this.size;
            maze[this.currentTile]["moveDown"] = !maze[this.currentTile]["moveDown"];
          });
          print(maze[this.currentTile]["moveDown"]);
        }
      }
      //tracks the new gesture from this starting point
      this.xStart = this.xCurrent;
      this.yStart = this.yCurrent;
    }
  }
  //handles the logic of determining directions from the swipe
  void handleSwipeEnd(DragEndDetails details) {
    //if using accessible controls each swipe and release results in 1 tile move
    if(this.accessibleControls) {
      //grabs the direction and magnitude in the x and y directions
      double deltaX = this.xCurrent - this.xStart;
      double deltaY = this.yCurrent - this.yStart;
      //if the swipe is more in the x direction
      if(deltaX.abs() > deltaY.abs()) {
        //if the swipe's x is greater than 0 it is to the right
        if(deltaX > 0 && maze[this.currentTile]["right"]) {
          print("right");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveRight"] = !maze[this.currentTile]["moveRight"];
            this.currentTile++;
            maze[this.currentTile]["moveLeft"] = !maze[this.currentTile]["moveLeft"];
          });
          print(maze[this.currentTile]["moveLeft"]);
        }
        //if the swipe's x is less than 0 it is to the left
        else if(deltaX < 0 && maze[this.currentTile]["left"]) {
          print("left");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveLeft"] = !maze[this.currentTile]["moveLeft"];
            this.currentTile--;
            maze[this.currentTile]["moveRight"] = !maze[this.currentTile]["moveRight"];
          });
          print(maze[this.currentTile]["moveRight"]);
        }
      }
      //if the swipe is more in the y direction
      else {
        //the swipes y is greater than 0 is is moving top down
        if(deltaY > 0 && maze[this.currentTile]["down"]) {
          print("down");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveDown"] = !maze[this.currentTile]["moveDown"];
            this.currentTile += this.size;
            maze[this.currentTile]["moveUp"] = !maze[this.currentTile]["moveUp"];
          });
          print(maze[this.currentTile]["moveUp"]);
        }
        //the swipes y is less than 0 is moving bottom up
        else if(deltaY < 0 && maze[this.currentTile]["up"]) {
          print("up");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveUp"] = !maze[this.currentTile]["moveUp"];
            this.currentTile -= this.size;
            maze[this.currentTile]["moveDown"] = !maze[this.currentTile]["moveDown"];
          });
          print(maze[this.currentTile]["moveDown"]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building maze");
    return GestureDetector(
      child: GridView.count(
        crossAxisCount: this.size,
        children: this.maze.map((dir) => Tile(directions: dir)).toList(),
        primary: false,
      ),
      onPanStart: this.handleSwipeStart,
      onPanUpdate: this.handleSwipeUpdate,
      onPanEnd: this.handleSwipeEnd,
    );
  }
}