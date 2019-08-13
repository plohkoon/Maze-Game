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
  _MazeState(size) {
    this.size = size;
    this.maze = MazeGenerators.primsAlgo(size);
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: this.size,
        children: this.maze.map((dir) => Tile(directions: dir)).toList()
      );
  }
}

/*[
    Testing the different maze tiles
    //single entrances
    {"up": true, "down": false, "left": false, "right": false},
    {"up": false, "down": true, "left": false, "right": false},
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
    {"up": true, "down": true, "left": true, "right": true},
  ];*/