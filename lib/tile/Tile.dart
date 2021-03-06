import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Tile extends StatefulWidget {
  final Map<String, bool> directions;
  final bool target;
  final bool currentTile;
  Tile({Key key, @required this.directions, this.target, this.currentTile}): super(key: key);

  _TileState createState() => _TileState(directions: directions, target: this.target, currentTile: this.currentTile);
}

class _TileState extends State<Tile> {
  //defines things being passed to the state
  Map<String, bool> directions;
  bool target;
  bool currentTile;
  //constructor
  _TileState({@required this.directions, this.target, this.currentTile});
  //3 lists to define the look of the player path in the tile
  List<Alignment> tileAlignment = new List<Alignment>.generate(2, (i) => Alignment.center);
  List<double> widths = new List<double>.generate(2, (i) => 0);
  List<double> heights = new List<double>.generate(2, (i) => 0);
  //initiates the state
  @override
  void initState() {
    this._updateMoves();
    super.initState();
  }  
  //on tile update updates the player path
  @override
  void didUpdateWidget(Tile oldWidget) {
    this.directions = this.widget.directions;
    this.target = this.widget.target;
    this.currentTile = this.widget.currentTile;
    this._updateMoves();
    super.didUpdateWidget(oldWidget);
  }
  //function to update the player path on the tile
  void _updateMoves() {
    //creates new instances of the list
    List<Alignment> tileAlignment = new List<Alignment>.generate(2, (i) => Alignment.center);
    List<double> widths = new List<double>.generate(2, (i) => 0);
    List<double> heights = new List<double>.generate(2, (i) => 0);
    //initiates a count
    int count = 0;
    /*
      These if statements stylize the paths,
      the try catch ensures it caps at 2 paths
      The catch should be unecessary as the nature of how 
      the pathing is created should guarantee that only 
      2 paths occur in any tile
    */
    try {
      if(directions["moveUp"]) {
        tileAlignment[count] = Alignment.topCenter;
        widths[count] = 0.2;
        heights[count] = 0.6;
        count++;
      }
      if(directions["moveLeft"]) {
        tileAlignment[count] = Alignment.centerLeft;
        widths[count] = 0.6;
        heights[count] = 0.2;
        count++;
      }
      if(directions["moveDown"]) {
        tileAlignment[count] = Alignment.bottomCenter;
        widths[count] = 0.2;
        heights[count] = 0.6;
        count++;
      }
      if(directions["moveRight"]) {
        tileAlignment[count] = Alignment.centerRight;
        widths[count] = 0.6;
        heights[count] = 0.2;
        count++;
      }
    }
    catch(error) {
      print("there's too many directions for a path");
    }
    //sets the values into the state
    this.tileAlignment = tileAlignment;
    this.widths = widths;
    this.heights = heights;
  }

  //builds the widget
  @override
  Widget build(BuildContext context) {
    return Container(
    child: Stack(
      children: <Widget>[
        //fills a dot in the center of the current tile
        Positioned.fill(
          child: FractionallySizedBox(
            alignment: Alignment.center,
            heightFactor: 0.2,
            widthFactor: 0.2,
            child: Container(
              color: currentTile ? Theme.of(context).primaryColorDark : null,
            )
          ),
        ),
        //fills out the color of the target
        Positioned.fill(
          child: FractionallySizedBox (
            alignment: Alignment.center,
            heightFactor: 1,
            widthFactor: 1,
            child: Container(
              color: this.target ? Theme.of(context).primaryColorDark : null
            ),
          ),
        ),
        //left wall extends from bottom left to the up
        Positioned.fill(
          child: FractionallySizedBox(
            alignment: Alignment.bottomLeft,
            heightFactor: this.directions["left"] ? 0.2 : 1,
            widthFactor: 0.2,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
          top: 0,
          left: 0,
        ),
        //top wall extends from top left to the right
        Positioned.fill(
          child: FractionallySizedBox(
            alignment: Alignment.topLeft,
            heightFactor: 0.2,
            widthFactor: this.directions["up"] ? 0.2 : 1,
            child: Container(
              color: Theme.of(context).primaryColor,
            )
          ),
          top: 0,
          left: 0,
        ),
        //right wall extends from top right to the down
        Positioned.fill(
          child: FractionallySizedBox(
            alignment: Alignment.topRight,
            heightFactor: this.directions["right"] ? 0.2 : 1,
            widthFactor: 0.2,
            child: Container(
              color: Theme.of(context).primaryColor,
            )
          ),
          top: 0,
          left: 0,
        ),
        //bottom wall extends from the bottom right to the left
        Positioned.fill(
          child: FractionallySizedBox(
            alignment: Alignment.bottomRight,
            heightFactor: 0.2,
            widthFactor: this.directions["down"] ? 0.2 : 1,
            child: Container(
              color: Theme.of(context).primaryColor,
            )
          ),
          top: 0,
          left: 0,
        ),
        //box to render part of the path on the tile
        Positioned.fill(
          child: FractionallySizedBox (
            alignment: this.tileAlignment[0],
            heightFactor: this.heights[0],
            widthFactor: this.widths[0],
            child: Container(
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
        //box to render other part of the path on the tile
        Positioned.fill(
          child: FractionallySizedBox (
            alignment: this.tileAlignment[1],
            heightFactor: this.heights[1],
            widthFactor: this.widths[1],
            child: Container(
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
      ],
    ),
    color: Theme.of(context).primaryColorLight
    );
  }
}
