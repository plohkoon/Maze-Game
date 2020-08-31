
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/data_streams.dart';

class ToggleDark extends StatefulWidget {
  @override
  _ToggleDarkState createState() => _ToggleDarkState();
}

class _ToggleDarkState extends State<ToggleDark> {
  bool darkMode;
  StreamSubscription darkModeListener;

  @override
  void initState() {
    darkMode = darkModeStream.value;
    this.darkModeListener = darkModeStream.makeListener((bool isDark) {
      setState(() {
        this.darkMode = isDark;
      });
    }, darkModeListener);
    super.initState();
  }

  @override
  void dispose() {
    darkModeListener.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: this.darkMode,
      onChanged: (_) => darkModeStream.toggle()
    );
  }
}