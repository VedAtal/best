import 'package:best/global/header_builder.dart';
import 'package:flutter/material.dart';

class DesktopTracker extends StatefulWidget {
  const DesktopTracker({super.key});

  @override
  State<DesktopTracker> createState() => _DesktopTrackerState();
}

class _DesktopTrackerState extends State<DesktopTracker> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        currentHeight,
        currentWidth,
        'Tracker',
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(
          currentWidth * 0.05,
          currentHeight * 0.05,
          currentWidth * 0.05,
          currentHeight * 0.05,
        ),
        child: Placeholder(),
      ),
    );
  }
}
