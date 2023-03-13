import 'package:best/extensions/transitionless_route.dart';
import 'package:best/global/variables.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final double currentWidth;
  final double currentHeight;
  final String title;
  final Color isSelected;

  const Menu(this.currentWidth, this.currentHeight, this.title, this.isSelected,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          currentWidth > currentHeight ? (currentHeight * 0.075) * 0.4 : null,
      margin: EdgeInsets.fromLTRB(
        currentWidth * 0.008,
        currentHeight * 0.001,
        currentWidth * 0.008,
        currentHeight * 0.001,
      ),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          Navigator.of(context).push(
              TransitionlessRoute(
                  builder: (context) => Variables.pageRoutes[title] as Widget));
        },
        child: FittedBox(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected,
              fontSize: currentWidth > currentHeight
                  ? currentWidth * 0.014
                  : currentHeight * 0.015,
            ),
          ),
        ),
      ),
    );
  }
}
