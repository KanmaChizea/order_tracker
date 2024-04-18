import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/navigation/navigation_service.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';

class OrderDeliveredModal extends StatelessWidget {
  const OrderDeliveredModal({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('lib/assets/animations/check.json', height: 100),
              AppSpacing.space(12),
              const Text(
                'Order Delivered!',
                style: AppTextstyles.heading1,
              ),
              AppSpacing.space(8),
              const Text(
                'Your order has been delivered successfully! Enjoy!',
                textAlign: TextAlign.center,
              ),
              AppSpacing.space(32),
              ElevatedButton(
                onPressed: () {
                  context.read<OrderCubit>().concludeOrder();
                  sl.get<NavigationService>().resetWith('/home');
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
