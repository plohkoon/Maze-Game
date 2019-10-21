import 'package:flutter/material.dart';

class ColorSlider extends StatefulWidget {
  //initializes the current value, colors list and setColor functions
  final int currentColor;
  final Function setColor;
  final List<Color> colors;
  //constructor
  ColorSlider({
    Key key,
    @required this.currentColor,
    @required this.setColor,
    this.colors = Colors.primaries,
  }) : super(key: key);
  @override
  _ColorSliderState createState() => _ColorSliderState(
    currentColor: this.currentColor,
    setColor: this.setColor,
    colors: this.colors,
  );
}

class _ColorSliderState extends State<ColorSlider> {
  //keeps track of the current color and the function to set the color
  int currentColor;
  Function setColor;
  List<Color> colors;
  //Constructor
  _ColorSliderState({this.currentColor, this.setColor, this.colors});

  @override
  void didUpdateWidget(ColorSlider oldWidget) {
    //sets the current index of color
    this.currentColor = this.widget.currentColor;
    //updates color array
    this.colors = this.widget.colors;
    super.didUpdateWidget(oldWidget);
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
          onPanStart: (DragStartDetails details) {
            //ensures that no weirdness with position can occur
            if(details.localPosition.dx < boxSize.maxWidth && details.localPosition.dx > 0) {
              int currentColor = (details.localPosition.dx ~/ size).toInt();
              this.setColor(currentColor);
            }
          },
          //when user pans proceeds to update color
          onPanUpdate: (DragUpdateDetails details) {
            //ensures that no weirdness with position can occur
            if(details.localPosition.dx < boxSize.maxWidth && details.localPosition.dx > 0) {
              int currentColor = (details.localPosition.dx ~/ size).toInt();
              this.setColor(currentColor);
            }
          },
        );
      }
    );
  }
}