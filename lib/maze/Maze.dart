import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/dataFlow/AccessibleStream.dart';
import 'package:maze_generator/tile/Tile.dart';
import 'package:maze_generator/maze/MazeGenerators.dart';
import 'dart:math' as Math;

class Maze extends StatefulWidget {
  Maze.blitz({Key key}): type = 'blitz', super(key: key);
  Maze.timeRush({Key key}): type = 'time rush', super(key: key);
  final String type;
  //the create state function
  @override
  _MazeState createState() => _MazeState(this.type);
}

class _MazeState extends State<Maze> {
  //holder for the maze and moves
  List<Map<String, bool>> maze;
  //keeps track of the square size and the in and out
  int size;
  int entrance;
  int exit;

  int currentTarget;
  //tracks the current tile we are in
  int currentTile;
  //tracks the start and current x positions of the current swipe
  double xStart;
  double yStart;
  double xCurrent;
  double yCurrent;
  //string to define the type of maze
  String type;
  //initializes base sizes
  final int blitzSize = 5;
  final int timeRushSize = 15;
  //tracks whether accesible controls or not
  bool accessibleControls;
  StreamSubscription accessibleStream;
  //a constant reference to a randomizer
  Math.Random randomizer = new Math.Random();
  //constructor
  _MazeState(this.type) {
    switch (this.type) {
      case 'blitz':
        this.size = this.blitzSize;
        break;
      case 'time rush':
        this.size = this.timeRushSize;
        break;
      default:
    }
  }
  //generates the initial maze
  @override
  void initState() {
    this._generateMaze();
    accessibleControls = AccessibleStream.accessible;
    accessibleStream = AccessibleStream.makeListener((bool isAccessible) {
      setState(() {
        accessibleControls = isAccessible;
      });
    }, accessibleStream);
    super.initState();
  }
  //when the size updates updates the internal size
  @override
  void didUpdateWidget(Maze oldMaze) {
    //if size changes updates maze
    if(oldMaze.type != this.widget.type) {
      this.type = this.widget.type;
      switch (this.type) {
        case 'blitz':
          this.size = this.blitzSize;
          break;
        case 'time rush':
          this.size = this.timeRushSize;
          break;
        default:
      }
      this._generateMaze();
    }
    super.didUpdateWidget(oldMaze);
  }

  @override
  void dispose() {
    accessibleStream.cancel();
    super.dispose();
  }
  //fucntion to generate the maze, grab current tile, and start/stop
  void _generateMaze() {
    //nullifies values to prevent accidental carry over of values
    this.currentTarget = null;
    this.currentTarget = null;
    this.exit = null;
    this.entrance = null;
    //switch to generate the proper maze
    switch (this.type) {
      case 'blitz':
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
        break;
      case 'time rush':
        //generates the maze
        List<Map<String, bool>> maze = MazeGenerators.primsAlgo(this.size);
        //if current tile is null generates a spot to start
        if(this.currentTile == null) {
          this.currentTile = randomizer.nextInt(this.size * this.size);
        }
        //ensures that the target generates but ensures its not on the start tile
        while(this.currentTarget == null || this.currentTarget == this.currentTile) {
          this.currentTarget = randomizer.nextInt(this.size * this.size);
        }
        //assignes the maze
        this.maze = maze;
        break;
      default:
    }
  }
  //when win condition for the maze is met triggers the maze regen
  void triggerBlitzWin() {
    setState(() {
      this.size++;
      this._generateMaze();
    });
  }
  void triggerTimeRushWin() {
    setState(() {
      this.currentTarget = randomizer.nextInt(this.size * this.size);
      this._generateMaze();
    });
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
        if(deltaY > 0 && maze[this.currentTile]["down"] && this.currentTile != this.exit) {
          print("down");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveDown"] = !maze[this.currentTile]["moveDown"];
            this.currentTile += this.size;
            maze[this.currentTile]["moveUp"] = !maze[this.currentTile]["moveUp"];
          });
          print(maze[this.currentTile]["moveUp"]);
        }
        else if(deltaY > 0 && maze[this.currentTile]["down"] && this.currentTile == this.exit) {
          this.triggerBlitzWin();
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
      if(this.currentTile == this.currentTarget) {
        this.triggerTimeRushWin();
      }
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
        if(deltaY > 0 && maze[this.currentTile]["down"] && this.currentTile != this.exit) {
          print("down");
          setState(() {
            //updates moves in the tiles
            maze[this.currentTile]["moveDown"] = !maze[this.currentTile]["moveDown"];
            this.currentTile += this.size;
            maze[this.currentTile]["moveUp"] = !maze[this.currentTile]["moveUp"];
          });
          print(maze[this.currentTile]["moveUp"]);
        }
        else if(deltaY > 0 && maze[this.currentTile]["down"] && this.currentTile == this.exit) {
          this.triggerBlitzWin();
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
      //checks the win state for
      if(this.currentTile == this.currentTarget) {
        this.triggerTimeRushWin();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    //uses a layout builder to ensure the maze always renders fully in the screen
    return LayoutBuilder(
      builder: (context, boxSize) {
        //grabs the maxHeigh and maxWidth possible of the box the maze is rendered in
        double maxHeight = boxSize.maxHeight;
        double maxWidth = boxSize.maxWidth;
        return SizedBox(
          //creates a gesture detector that will handle the swiping on the maze 
          child: GestureDetector(
            //GridView that renders the maze off a 1 dimensional list
            child: GridView.count(
              crossAxisCount: this.size,
              crossAxisSpacing: 0,
              children:
                this.maze
                    .asMap()
                    .map((index, dir) => MapEntry<int, Tile>(index, Tile(directions: dir, target: index == this.currentTarget, currentTile: index == this.currentTile)))
                    .values
                    .toList(),
              primary: false,
              shrinkWrap: true,
            ),
            //defines the gesture function
            onPanStart: this.handleSwipeStart,
            onPanUpdate: this.handleSwipeUpdate,
            onPanEnd: this.handleSwipeEnd,
          ),
          //if in portrait mode renders the square size as the size of the max width
          height: maxHeight > maxWidth ?
            maxWidth :
            maxHeight,
          //if in landscape mode renders the square size as the size of the max height
          width: maxWidth > maxHeight ?
            maxHeight :
            maxWidth,
        );
      },
    );
  }
}
