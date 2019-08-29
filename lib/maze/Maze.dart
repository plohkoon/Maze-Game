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
  List<Map<String, bool>> maze;
  int size;
  static final Math.Random randomizer = Math.Random();
  _MazeState(size) {
    this.size = size;
    this.maze = MazeGenerators.primsAlgo(size);
    int start = randomizer.nextInt(size);
    int end = randomizer.nextInt(size);
    this.maze[start]["up"] = true;
    this.maze[this.size - end]["down"] = true;
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: this.size,
        children: this.maze.map((dir) => Tile(directions: dir)).toList()
      );
  }
}