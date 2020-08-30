import 'dart:async';
// TODO Potentially use this
class DataStream<T> {

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

class ToggleStream extends DataStream<bool> {
  void toggle() {
    this.setValue(!_value);
  }
}