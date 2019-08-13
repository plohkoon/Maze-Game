import 'dart:developer';

import 'dart:math' as Math;

class MazeGenerators {
  static Math.Random randomizer = Math.Random();
  //a private function to generate an empty maaze to be generated upon
  static List<List<Map<String, bool>>> _emptyMaze(int size) {
    //initates to outer array
    List<List<Map<String, bool>>> empty = new List(size);
    //runs through the outer array filling rows in
    for(int i = 0; i < size; i++) {
      List<Map<String, bool>> currentRow = new List(size);
      //runs through rows filling cells with all the walls
      for(int j = 0; j < size; j++) {
        currentRow[j] = {
          "up": false,
          "right": false,
          "down": false,
          "left": false,
        };
      }
      empty[i] = currentRow;
    }
    log(empty.toString());
    return empty;
  }
  static List<Map<String, bool>> recursiveBacktrack(int size) {
    //grabs a new maze
    List<List<Map<String, bool>>> maze = _emptyMaze(size);
    return maze.expand((row) => row).toList();
  //another implementation of a maze algorithm, this generates a much more erractic and harder to find path
  static List<Map<String, bool>> primsAlgo(int size) {
    //initializes the empty maze
    List<List<Map<String, bool>>> maze = _emptyMaze(size);
    return maze.expand((row) => row).toList();
  }
}