import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/model/async_value.dart';
import 'package:order_tracker/screens/login/email_login_view_model.dart';
import 'package:order_tracker/widgets/login/error_state.dart';
import 'package:order_tracker/widgets/login/login_form.dart';
import 'package:order_tracker/widgets/shared/view_model_widget.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelScreenWrapper<EmailLoginViewModel,
        AsyncValue<EmailLoginViewState>>(
      viewModel: (context) => EmailLoginViewModel(),
      child: (context, state) {
        return state.when(
          isLoading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          hasError: (message) => LoginErrorState(
            message: message,
            clearFunction: context.read<EmailLoginViewModel>().clearError,
          ),
          hasData: (data) => const LoginForm(),
        );
      },
    );
  }
}
