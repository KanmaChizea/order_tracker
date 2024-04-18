import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/model/auth_states.dart';
import 'package:order_tracker/screens/home/home_view_model.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';
import 'package:order_tracker/widgets/home/action_menu.dart';
import 'package:order_tracker/widgets/home/empty_state.dart';
import 'package:order_tracker/widgets/home/order_state.dart';
import 'package:order_tracker/widgets/shared/view_model_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelScreenWrapper<HomeViewModel, void>(
      viewModel: (context) => HomeViewModel(),
      child: (context, _) {
        if (context.watch<UserCubit>().state is UserSignedIn) {
          final user = (context.watch<UserCubit>().state as UserSignedIn).user;
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text('Hi ${user.getFirstName()},',
                            style: AppTextstyles.heading2),
                        AppSpacing.space(4),
                        const Spacer(),
                        const ActionMenu(),
                      ],
                    ),
                    AppSpacing.space(32),
                    Builder(
                      builder: (context) {
                        if (context.watch<OrderCubit>().state == null) {
                          return const Expanded(child: HomeEmptyState());
                        }
                        return const HomeOrderState();
                      },
                    )
                  ],
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
