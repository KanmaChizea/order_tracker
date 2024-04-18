import 'package:flutter/material.dart';

class BounceAnimation extends AnimatedWidget {
  const BounceAnimation({
    required Animation<double> animation,
    required this.child,
    super.key,
  }) : super(listenable: animation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, animation.value),
      child: child,
    );
  }
}
