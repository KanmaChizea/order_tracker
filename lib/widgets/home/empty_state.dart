import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'lib/assets/svgs/trolley.svg',
          height: 100,
        ),
        AppSpacing.space(16),
        const Text(
          'No active orders',
          style: AppTextstyles.heading1,
        ),
        AppSpacing.space(8),
        const Text(
          'Your ongoing order will be displayed here once you make an order',
          textAlign: TextAlign.center,
        ),
        AppSpacing.space(36),
        ElevatedButton(
          onPressed: context.read<OrderCubit>().resetOrder,
          child: const Text('Place an order'),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
