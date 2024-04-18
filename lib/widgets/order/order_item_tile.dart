import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_tracker/model/item.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';

class OrderItemTile extends StatelessWidget {
  const OrderItemTile({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            item.imagePath,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        AppSpacing.space(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.name} x${item.quantity}',
              style: AppTextstyles.bodyBold,
            ),
            Text(item.description, style: AppTextstyles.subHeading),
          ],
        ),
        const Spacer(),
        Text(
          NumberFormat.simpleCurrency(
            decimalDigits: 2,
            name: 'NGN',
          ).format(item.price),
        )
      ],
    );
  }
}
