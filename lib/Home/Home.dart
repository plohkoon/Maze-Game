

import 'package:flutter/material.dart';
import 'package:maze_generator/Customizations/ColorSlider.dart';
import 'package:maze_generator/Customizations/ToggleDark.dart';

class Home extends StatefulWidget {
  Home({Key key}): super(key:key);

  _HomeState createState () => _HomeState();
}
// TODO Can this be stateless?
class _HomeState extends State<Home> {

  Map<String,List<DateTime>> data = {
    "Blitz": [
      new DateTime(0,0,0,0,15,5,10),
      new DateTime(0,0,0,0,15,5,10),
      new DateTime(0,0,0,0,15,5,10)
    ],
    "Time Rush": [
      new DateTime(0,0,0,0,30,20,10),
      new DateTime(0,0,0,0,30,20,10),
      new DateTime(0,0,0,0,30,20,10),
    ]
  };

  Widget build(BuildContext buildContext) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //maps the data to the children
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Difficulty"),
                    RaisedButton(
                      child: Text("Easy"),
                      color: Theme.of(buildContext).primaryColor,
                      disabledColor: Theme.of(buildContext).primaryColor,
                      onPressed: null,
                    ),
                    RaisedButton(
                      child: Text("Medium"),
                      onPressed: null
                    ),
                    RaisedButton(
                      child: Text("Hard"),
                      onPressed: null
                    ),
                  ],
                )
              )
            ] + data.map((type, data){
              return MapEntry<String, Widget>(
                type,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text(type)] + data.map((DateTime value) => Text(value.toString())).toList()
                  )
                )
              );
            }).values.toList()
            /*<Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(height: 100, width: 100, color: Colors.black),
                    Container(height: 100, width: 100, color: Colors.black),
                    Container(height: 100, width: 100, color: Colors.black),
                  ],
                )
              )
            ],*/
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ColorSlider(),
            ),
            ToggleDark()
          ],
        ),
      ],
    );
  }
}