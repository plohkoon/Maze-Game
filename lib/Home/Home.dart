

import 'package:flutter/material.dart';
import 'package:maze_generator/ColorSlider/ColorSlider.dart';

class Home extends StatefulWidget {
  final int currentColor;
  final Function setColor;
  final bool darkMode;
  final Function setDark;

  Home({Key key, this.currentColor, this.setColor, this.darkMode, this.setDark}): super(key:key);

  _HomeState createState () => _HomeState(this.currentColor, this.setColor, this.darkMode, this.setDark);
}

class _HomeState extends State<Home> {

  int currentColor;
  Function setColor;
  bool darkMode;
  Function setDark;

  _HomeState(this.currentColor, this.setColor, this.darkMode, this.setDark);

  @override
  void didUpdateWidget(Home oldWidget) {
    this.currentColor = this.widget.currentColor;
    this.darkMode = this.widget.darkMode;

    super.didUpdateWidget(oldWidget);
  }

  Widget build(BuildContext buildContext) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text("Difficulty"),
                    Text("Blitz"),
                    Text("Time Rush")
                  ],
                )
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text("Easy")
                  ],
                )
              ),
              Expanded(
                child: Row(
                  children: <Widget> [
                    Text("Medium")
                  ]
                )
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text("Hard")
                  ],
                )
              )
            ],
          )
        ),
        Row(
          children: [
            Expanded(
              child: ColorSlider(
                currentValue: currentColor,
                setColor: setColor,
              ),
            ),
            Switch(
              value: this.darkMode,
              onChanged: this.setDark
            )
          ],
        ),
      ],
    );
  }
}