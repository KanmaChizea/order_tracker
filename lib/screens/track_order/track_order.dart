import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/model/order.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';
import 'package:order_tracker/widgets/order/stepper.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = context.watch<OrderCubit>().state;
    if (order == null) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${order.id} Timeline'),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: CustomStepper(
            currentIndex: order.status.index,
            steps: OrderStatus.values
                .map(
                  (status) => (
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.getStatusString(status),
                          style: AppTextstyles.bodyBold,
                        ),
                        order.getStatusDate(status) != null
                            ? Text(
                                DateFormat('hh:ss aa')
                                    .format(order.getStatusDate(status)!)
                                    .toLowerCase(),
                                style: AppTextstyles.subHeading,
                              )
                            : const Text('—')
                      ],
                    ),
                    description: Text(
                      order.getStatusDescription(status),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
