import 'dart:async';
import 'package:flutter/material.dart';
class ColorStream {

  static StreamController<Color> _controller = new StreamController.broadcast();
  static Color _color = Colors.primaries[0];

  static Stream get stream {
    return _controller.stream;
  }

  static Color get color {
    return _color;
  }

  static void setColor(Color newColor) {
    _color = newColor;
    _controller.add(_color);
  }

  static StreamSubscription<Color> makeListener(Function(Color) callback, StreamSubscription oldListener) {
    if(oldListener != null) oldListener.cancel();
    return _controller.stream.listen(callback);
  }
}