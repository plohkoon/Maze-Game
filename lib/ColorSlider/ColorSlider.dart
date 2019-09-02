import 'package:flutter/material.dart';

class ColorSlider extends StatefulWidget {
  final int currentValue;
  final Function setColor;
  ColorSlider({Key key, this.currentValue, this.setColor}) : super(key: key);
  @override
  _ColorSliderState createState() => _ColorSliderState(currentColor: this.currentValue, setColor: this.setColor);
}

class _ColorSliderState extends State<ColorSlider> {
  //keeps track of the current color and the function to set the color
  int currentColor;
  Function setColor;
  //Constructor
  _ColorSliderState({this.currentColor, this.setColor});
  //initializes the value for the slider
  double currentValue;

  @override
  void initState() {
    //sets the value and the color
    this.currentValue = this.widget.currentValue.toDouble();
    this.currentColor = this.widget.currentValue;
    super.initState();
  }
  @override
  void didUpdateWidget(ColorSlider oldWidget) {
    //sets the value and the color
    this.currentValue = this.widget.currentValue.toDouble();
    this.currentColor = this.widget.currentValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //builds the custom theme for the slider
    return Theme(
      data: ThemeData(
        sliderTheme: SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
          valueIndicatorColor: Colors.primaries[this.currentValue.toInt()],
        )
      ),
      //builds the slider
      child: Slider(
        value: this.currentValue,
        min: 0,
        max: Colors.primaries.length.toDouble() - 1,
        divisions: Colors.primaries.length - 1,
        onChanged: (index) => setState(() => this.currentValue=index),
        onChangeEnd: (index) => setColor(this.currentValue),
      ),
    );
  }
}