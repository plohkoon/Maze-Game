import 'dart:async';
class AccessibleStream {

  static StreamController<bool> _controller = new StreamController.broadcast();
  static bool _accessible = false;

  static Stream get stream {
    return _controller.stream;
  }

  static bool get accessible {
    return _accessible;
  }

  static void toggleAccessible() {
    _accessible = !_accessible;
    _controller.add(_accessible);
  }

  static StreamSubscription makeListener(Function(bool) callback, StreamSubscription oldListener) {
    if(oldListener != null) oldListener.cancel();
    return _controller.stream.listen(callback);
  }
}