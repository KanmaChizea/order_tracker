import 'package:flutter/material.dart';
import 'package:order_tracker/animations/bounce.dart';

class StepperIcon extends StatefulWidget {
  const StepperIcon({
    required this.shouldAnimate,
    required this.color,
    super.key,
  });
  final bool shouldAnimate;
  final Color color;
  @override
  State<StepperIcon> createState() => _StepperIconState();
}

class _StepperIconState extends State<StepperIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Color color;
  late bool shouldAnimate;

  @override
  void initState() {
    super.initState();
    color = widget.color;
    shouldAnimate = widget.shouldAnimate;

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    animation = Tween<double>(begin: -20, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,
      ),
    );
    startAnimation();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    if (shouldAnimate) {
      animationController.forward();
      animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
    return shouldAnimate
        ? BounceAnimation(
            animation: animation,
            child: icon,
          )
        : icon;
  }
}
