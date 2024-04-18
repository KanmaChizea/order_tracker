import 'package:flutter/material.dart';
import 'package:order_tracker/theme/textstyles.dart';

class OrderDetailRow extends StatelessWidget {
  const OrderDetailRow({required this.label, required this.value, super.key});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextstyles.heading3,
        ),
        Text(
          value,
          style: AppTextstyles.bodyBold,
        ),
      ],
    );
  }
}
