import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/data_streams.dart';

class ColorSlider extends StatefulWidget {
  final List<Color> colors;

  ColorSlider({
    Key key,
    this.colors = Colors.primaries,
  }) : super(key: key);

  @override
  _ColorSliderState createState() => _ColorSliderState(
    colors: this.colors,
  );
}

class _ColorSliderState extends State<ColorSlider> {
  //keeps track of the current color and the function to set the color
  int currentColor;
  StreamSubscription colorListener;
  List<Color> colors;
  //Constructor
  _ColorSliderState({this.colors});

  @override
  void initState() {
    // Tries to find the current color otherwise sets it to the first index
    currentColor = this.colors.indexOf(colorStream.value);
    if(this.colors != Colors.primaries || currentColor < 0) {
      currentColor = 0;
      colorStream.setValue(colors[0]);
    }

    this.colorListener = colorStream.makeListener((Color newColor) {
      setState(() {
        this.currentColor = this.colors.indexOf(colorStream.value);
      });
    }, this.colorListener);
    super.initState();
  }

  @override
  void dispose() {
    this.colorListener.cancel();
    super.dispose();
  }

  void setColor(Offset offset, BoxConstraints boxSize) {
    double size = boxSize.maxWidth / colors.length;
    if(offset.dx < boxSize.maxWidth && offset.dx > 0) {
      int currentColor = (offset.dx ~/ size).toInt();
      colorStream.setValue(this.colors[currentColor]);
    }
  }

  @override
  Widget build(BuildContext context) {
    //builds the custom color slider
    return LayoutBuilder(
      builder: (context, boxSize) {
        //calculates the size of each individual color square
        double size = boxSize.maxWidth / colors.length;
        return GestureDetector(
          //stack to allow the current selection indicators to overlay slightly with
          child: Stack(
            children: [
              Container(
                child: Row(
                  //maps the colors in the array to children
                  children: this.colors
                                .map((color) => Container(
                                    color: color,
                                    height: size,
                                    width: size,
                                  )
                                )
                                .toList()
                ),
                //sets the top margin of the color bar to allow for overlay with the icons
                margin: EdgeInsets.only(
                  top: size * 0.5,
                ),
              ),
              Container(
                child: Icon(Icons.arrow_drop_down, size: size,),
                height: size,
                width: size,
                margin: EdgeInsets.only(
                  left: this.currentColor * size,
                ),
              ),
              Container(
                child: Icon(Icons.arrow_drop_up, size: size,),
                height: size,
                width: size,
                margin: EdgeInsets.only(
                  left: this.currentColor * size,
                  top: size * 0.5 * 2,
                ),
              ),
            ],
          ),
          //when user taps and starts pan updates color
          onPanStart: (DragStartDetails details) => setColor(details.localPosition, boxSize),
          //when user pans proceeds to update color
          onPanUpdate: (DragUpdateDetails details)  => setColor(details.localPosition, boxSize)
        );
      }
    );
  }
}