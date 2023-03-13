import 'package:best/global/header_builder.dart';
import 'package:flutter/material.dart';

class DesktopJuntos extends StatefulWidget {
  const DesktopJuntos({super.key});

  @override
  State<DesktopJuntos> createState() => _DesktopJuntosState();
}

class _DesktopJuntosState extends State<DesktopJuntos> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        currentHeight,
        currentWidth,
        'Juntos',
      ),
      body: Placeholder(),
    );
  }
}
