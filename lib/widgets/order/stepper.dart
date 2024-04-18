import 'package:flutter/material.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/widgets/order/stepper_icon.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    required this.steps,
    required this.currentIndex,
    this.direction = Axis.vertical,
    this.activeColor,
    this.inactiveColor,
    super.key,
  }) : assert(currentIndex <= steps.length);

  final List<({Widget title, Widget description})> steps;
  final int currentIndex;
  final Axis direction;
  final Color? activeColor;
  final Color? inactiveColor;
  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? Colors.teal.shade700;
    final inactive = inactiveColor ?? Colors.teal.shade100;
    return ListView.separated(
      scrollDirection: direction,
      shrinkWrap: true,
      itemCount: steps.length,
      separatorBuilder: (context, index) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: 2,
            height: 24,
            margin: const EdgeInsets.only(left: 9),
            color: index < currentIndex ? active : inactive),
      ),
      itemBuilder: (context, index) => Row(
        children: [
          StepperIcon(
            key: ValueKey(currentIndex),
            shouldAnimate: index == currentIndex,
            color: index <= currentIndex ? active : inactive,
          ),
          AppSpacing.space(16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  steps[index].title,
                  if (index == currentIndex) steps[index].description,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
