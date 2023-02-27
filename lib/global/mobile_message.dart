import 'package:flutter/material.dart';

class MobileMessage extends StatelessWidget {
  const MobileMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'The mobile site is currently under development. Please'
              ' visit the site on desktop to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: currentWidth * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
