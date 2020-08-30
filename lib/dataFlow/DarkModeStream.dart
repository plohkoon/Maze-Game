import 'dart:async';
class DarkModeStream {

  static StreamController<bool> _controller = new StreamController.broadcast();
  static bool _darkMode = false;

  static Stream get stream {
    return _controller.stream;
  }

  static bool get darkMode {
    return _darkMode;
  }

  static void toggleDarkMode() {
    _darkMode = !_darkMode;
    _controller.add(_darkMode);
  }

  static StreamSubscription makeListener(Function(bool) callback, StreamSubscription oldListener) {
    if(oldListener != null) oldListener.cancel();
    return _controller.stream.listen(callback);
  }
}