import 'package:flutter/material.dart';
import 'package:order_tracker/model/order.dart';

class OrderStatusBar extends StatelessWidget {
  const OrderStatusBar({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.placed) {
      return const LinearProgressIndicator();
    }

    final barCount = OrderStatus.values.length;
    final spacingWidth =
        (barCount - 1) * 16; // size of spacing between each bar by no of spaces
    final itemWidth =
        (MediaQuery.of(context).size.width - spacingWidth) / barCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List<Widget>.generate(
        barCount,
        (index) {
          return Container(
            height: 4,
            width: itemWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: index <= status.index ? Colors.teal : Colors.teal.shade100,
            ),
          );
        },
      ),
    );
  }
}
