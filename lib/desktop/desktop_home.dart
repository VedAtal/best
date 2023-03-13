import 'package:best/global/header_builder.dart';
import 'package:flutter/material.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        currentHeight,
        currentWidth,
        'Home',
      ),
      body: Placeholder(),
    );
  }
}
