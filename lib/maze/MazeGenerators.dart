import 'dart:math' as Math;
/*
A class full of static methods to generate mazes
that are various methods of doing such task
*/
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
    return empty;
  }
  //implements the recursive backtrack method of generating mazes
  static List<Map<String, bool>> recursiveBacktrack(int size) {
    //grabs a new maze
    List<List<Map<String, bool>>> maze = _emptyMaze(size);
    //creates the array of visited values
    List<List<bool>> visited = new List(size);
    //initializes the cells that have been visited
    for(int i = 0; i < size; i++) {
      visited[i] = new List(size);
      for(int j = 0; j < size; j++) {
        visited[i][j] = false;
      }
    }
    //grabs an integer
    int col = randomizer.nextInt(size);
    //runs the recursive
    _runRecursiveBacktrack(0, col, size, visited, maze);

    return maze.expand((row) => row).toList();
  }
  //the actual recursive implementation in a private function
  //void
  static void _runRecursiveBacktrack(
    int row,
    int col,
    int dim,
    List<List<bool>> visited,
    List<List<Map<String, bool>>> maze
  ) {
    //sets the current cell to visited
    visited[row][col] = true;
    //initializes an array of directions
    List<String> directions = ["up", "left", "down", "right"];
    //while directions are still available
    while(directions.length > 0) {
      //grabs a new direction
      int dirInd = randomizer.nextInt(directions.length);
      String direction = directions[dirInd];
      //initializes and gets the new row or col depending on direction
      int newrow = row, newcol = col;
      switch (direction) {
        case "up":
          newrow--;
          break;
        case "left":
          newcol--;
          break;
        case "down":
          newrow++;
          break;
        case "right":
          newcol++;
          break;
        default:
      }
      //if out of bounds skips
      if(newrow < 0 || newcol < 0 || newrow >= dim || newcol >= dim) {
        directions.removeAt(dirInd);
      }
      //if already visited skips
      else if(visited[newrow][newcol]) {
        directions.removeAt(dirInd);
      }
      //else flips the direction to a path
      else {
        maze[row][col][direction] = true;
        //flips the opposite direction in the chosen tile to a path
        switch (direction) {
          case "up":
            maze[newrow][newcol]["down"] = true;
            break;
          case "down":
            maze[newrow][newcol]["up"] = true;
            break;
          case "left":
            maze[newrow][newcol]["right"] = true;
            break;
          case "right":
            maze[newrow][newcol]["left"] = true;
            break;
          default:
        }
        directions.removeAt(dirInd);
        //recurses to the next tile
        _runRecursiveBacktrack(newrow, newcol, dim, visited, maze);
      }
    }
  }
  //another implementation of a maze algorithm, this generates a much more erractic and harder to find path
  static List<Map<String, bool>> primsAlgo(int size) {
    //initializes the empty maze
    List<List<Map<String, bool>>> maze = _emptyMaze(size);
    //grabs the first cell
    int firstRow = randomizer.nextInt(size), firstCol = randomizer.nextInt(size);
    //creates the walls list with directions (0 up, 1 right, 2 down, 3 left)
    List<Map<String, int>> walls = List();
    walls.addAll([
      {"row": firstRow, "col": firstCol, "dir": 0},
      {"row": firstRow, "col": firstCol, "dir": 1},
      {"row": firstRow, "col": firstCol, "dir": 2},
      {"row": firstRow, "col": firstCol, "dir": 3},
    ]);
    //creates the array of visited values
    List<List<bool>> visited = new List(size);
    //initializes the cells that have been visited
    for(int i = 0; i < size; i++) {
      visited[i] = new List(size);
      for(int j = 0; j < size; j++) {
        visited[i][j] = false;
      }
    }
    int row = firstRow, col = firstCol;
    //starts the process so long as there are walls proceed
    while(walls.length > 0) {
      //grabs a random wall
      int wallIndex = randomizer.nextInt(walls.length);
      //extracts the wall from the list
      Map<String, int> wall = walls[wallIndex];
      //grabs the row and column to reference`
      row = wall["row"]; col = wall["col"];
      int newRow = wall["row"], newCol = wall["col"];
      //extracts the direction and adjusts the current row and col
      String direction = "";
      String opposite = "";
      switch (wall["dir"]) {
        case 0:
          newRow--;
          direction = "up";
          opposite = "down";
          break;
        case 1:
          newCol++;
          direction = "right";
          opposite = "left";
          break;
        case 2:
          newRow++;
          direction = "down";
          opposite = "up";
          break;
        case 3:
          newCol--;
          direction = "left";
          opposite = "right";
          break;
        default:
      }
      //if we're out of bounds removes the wall and proceeds
      if(newRow < 0 || newCol < 0 || newRow >= size || newCol >= size) {
        walls.removeAt(wallIndex);
      }
      //if we have been there through another path removes the wall and proceeds
      else if(visited[newRow][newCol]) {
        walls.removeAt(wallIndex);
      }
      else {
        //ensures the cells are set to visited
        visited[row][col] = true;
        visited[newRow][newCol] = true;
        //sets the 2 cells directions
        maze[row][col][direction] = true;
        maze[newRow][newCol][opposite] = true;
        //removes the walls
        walls.removeAt(wallIndex);
        //initializes the new list of walls
        List<Map<String, int>> newWalls = new List();
        //runs through and grabs all the new walls
        for(int i = 0; i < 4; i++) {
          //the wall that has been used is always going to be x+ 2 mod 4 away
          if(i != (wall["dir"] + 2) % 4) {
            newWalls.add({"row": newRow, "col": newCol, "dir": i});
          }
        }
        //adds the walls to the list
        walls.addAll(newWalls);
      }
    }

    return maze.expand((row) => row).toList();
  }
}