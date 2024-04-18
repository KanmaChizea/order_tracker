import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/screens/home/home_view_model.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';
import 'package:order_tracker/widgets/order/order_detail_row.dart';
import 'package:order_tracker/widgets/order/order_item_tile.dart';
import 'package:order_tracker/widgets/order/order_status_bar.dart';

class HomeOrderState extends StatelessWidget {
  const HomeOrderState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final order = context.watch<OrderCubit>().state!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR ACTIVE ORDER',
          style: AppTextstyles.overline,
        ),
        AppSpacing.space(24),
        Text(order.getStatusDescription()),
        AppSpacing.space(8),
        OrderStatusBar(status: order.status),
        AppSpacing.space(4),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: context.read<HomeViewModel>().goToTrackOrder,
            label: const Icon(Icons.arrow_forward),
            icon: const Text('Track your order'),
          ),
        ),
        AppSpacing.space(24),
        OrderDetailRow(
          label: 'Order ID',
          value: '#${order.id}',
        ),
        AppSpacing.space(16),
        OrderDetailRow(
          label: 'Order Date',
          value: DateFormat('EEE dd/mm/yyyy').format(order.date),
        ),
        const Divider(height: 36),
        const Text(
          'Order Items',
          style: AppTextstyles.overline,
        ),
        AppSpacing.space(16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => AppSpacing.space(24),
          itemBuilder: (context, index) => OrderItemTile(
            item: order.items[index],
          ),
          itemCount: order.items.length,
        )
      ],
    );
  }
}
