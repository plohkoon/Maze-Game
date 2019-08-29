import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maze_generator/tile/Tile.dart';
import 'package:maze_generator/maze/MazeGenerators.dart';
import 'dart:math' as Math;

class Maze extends StatefulWidget {

  Maze({Key key, this.size}): super(key: key);

  final int size;

  @override
  _MazeState createState() => _MazeState(size);
}

class _MazeState extends State<Maze> {
  //holder for the maze and moves
  List<Map<String, bool>> maze;

  //keeps track of the square size and the in and out
  int size;
  int entrance;
  int exit;
  //a constant reference to a randomizer
  Math.Random randomizer = new Math.Random();
  //constructor
  _MazeState(this.size);
  //generates the initial maze
  @override
  void initState() {
    log("Setting initial maze");
    this._generateMaze();
    super.initState();
  }
  //when the size updates updates the internal size
  @override
  void didUpdateWidget(Maze oldMaze) {
    //if size changes updates maze
    if(oldMaze.size != this.widget.size) {
      this.size = oldMaze.size;
      this._generateMaze();
    }
    super.didUpdateWidget(oldMaze);
  }
  
  void _generateMaze() {
    //generates the maze
    List<Map<String, bool>> maze = MazeGenerators.recursiveBacktrack(this.size);
    //generates the entrance and exit position in top and bottom rows
    int start = randomizer.nextInt(this.size);
    int end = maze.length - 1 - randomizer.nextInt(this.size);
    //opens the walls at entrance and exit
    maze[start]["up"] = true;
    maze[end]["down"] = true;
    //sets the in and out class variables
    this.entrance = start;
    this.exit = end;
    //sets the maze
    this.maze = maze;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: this.size,
        children: this.maze.map((dir) => Tile(directions: dir)).toList()
      );
  }
}