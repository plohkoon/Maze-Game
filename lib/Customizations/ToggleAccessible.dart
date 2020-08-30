import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maze_generator/dataFlow/AccessibleStream.dart';

class ToggleAccessible extends StatefulWidget {
  @override
  _ToggleAccessibleState createState() => _ToggleAccessibleState();
}

class _ToggleAccessibleState extends State<ToggleAccessible> {
  bool isAccessible;
  StreamSubscription accessibleStream;

  @override
  void initState() {
    isAccessible = AccessibleStream.accessible;
    accessibleStream = AccessibleStream.makeListener((bool isAccessible) {
      setState(() {
        this.isAccessible = isAccessible;
      });
    }, this.accessibleStream);
    super.initState();
  }

  @override
  void dispose() {
    this.accessibleStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Accessibility Controls"),
        Switch(
          value: this.isAccessible,
          onChanged: (_) => AccessibleStream.toggleAccessible()
        )
      ],
    );
  }
}