import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';

class LoginErrorState extends StatelessWidget {
  const LoginErrorState({
    required this.message,
    required this.clearFunction,
    super.key,
  });

  final String message;
  final Function() clearFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Row(
            children: [
              Lottie.asset('lib/assets/animations/cancel.json',
                  width: 150, repeat: false),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Error!',
                      style: AppTextstyles.heading2,
                    ),
                    AppSpacing.space(8),
                    Text(message),
                  ],
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: clearFunction,
            child: const Text('Try again'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
