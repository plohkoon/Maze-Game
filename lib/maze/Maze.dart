import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maze_generator/tile/Tile.dart';
import 'package:maze_generator/maze/MazeGenerators.dart';

class Maze extends StatefulWidget {

  Maze({Key key, this.size}): super(key: key);

  final int size;

  @override
  _MazeState createState() => _MazeState(size);
}

class _MazeState extends State<Maze> {
  List<Map<String, bool>> maze;
  int size;
  _MazeState(this.size);
  //generates the initial maze
  @override
  void initState() {
    log("Setting initial maze");
    this.maze = MazeGenerators.recursiveBacktrack(this.size);
    super.initState();
  }
  //when the size updates updates the internal size
  @override
  void didUpdateWidget(Maze newMaze) {
    if(newMaze.size != this.size) {
      this.size = newMaze.size;
      this.maze = MazeGenerators.recursiveBacktrack(this.size);
    }
    super.didUpdateWidget(newMaze);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: this.size,
        children: this.maze.map((dir) => Tile(directions: dir)).toList()
      );
  }
}