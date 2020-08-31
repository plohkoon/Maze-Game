library data_streams;

import 'dart:async';
import 'package:flutter/material.dart';

class _DataStream<T> {

  StreamController<T> _controller = new StreamController.broadcast();
  T _value;

  Stream get stream {
    return _controller.stream;
  }

  T get value {
    return _value;
  }

  void setValue(T newValue) {
    _value = newValue;
    _controller.add(_value);
  }

  StreamSubscription<T> makeListener(Function(T) callback, StreamSubscription oldListener) {
    if(oldListener != null) oldListener.cancel();
    return _controller.stream.listen(callback);
  }
}

class _ToggleStream extends _DataStream<bool> {
  _ToggleStream(bool initialValue) {
    this._value = initialValue;
  }
  void toggle() {
    this.setValue(!_value);
  }
}
// TODO somehow store these states
final _ToggleStream accessibleStream = _ToggleStream(false);
final _ToggleStream darkModeStream = _ToggleStream(false);
final _DataStream<Color> colorStream = _DataStream<Color>();