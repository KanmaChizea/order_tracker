import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/theme/spacing.dart';

class ViewModelScreenWrapper<T extends BlocBase<R>, R> extends StatelessWidget {
  const ViewModelScreenWrapper({
    required this.child,
    required this.viewModel,
    this.appBar,
    super.key,
  });

  final Widget Function(BuildContext context, R state) child;
  final T Function(BuildContext context) viewModel;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: viewModel,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: appBar,
            body: SafeArea(
              child: Padding(
                padding: AppSpacing.screenPadding,
                child: child(context, context.watch<T>().state),
              ),
            ),
          );
        },
      ),
    );
  }
}
