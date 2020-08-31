import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/data_streams.dart';

class ToggleAccessible extends StatefulWidget {
  @override
  _ToggleAccessibleState createState() => _ToggleAccessibleState();
}

class _ToggleAccessibleState extends State<ToggleAccessible> {
  bool isAccessible;
  StreamSubscription accessibleListener;

  @override
  void initState() {
    isAccessible = accessibleStream.value;
    accessibleListener = accessibleStream.makeListener((bool isAccessible) {
      setState(() {
        this.isAccessible = isAccessible;
      });
    }, this.accessibleListener);
    super.initState();
  }

  @override
  void dispose() {
    this.accessibleListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Accessibility Controls"),
        Switch(
          value: this.isAccessible,
          onChanged: (_) => accessibleStream.toggle()
        )
      ],
    );
  }
}