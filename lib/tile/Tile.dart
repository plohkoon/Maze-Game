import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Tile extends StatelessWidget {
  final Map<String, bool> directions;
  Tile({Key key, @required this.directions}): super(key: key);

  //builds the widget
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
      ],
    );
  }
}