import 'package:flutter/material.dart';

class TransitionlessRoute<T> extends MaterialPageRoute<T> {
  TransitionlessRoute({required WidgetBuilder builder}) : super(builder: builder);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
