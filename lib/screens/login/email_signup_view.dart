import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/model/async_value.dart';
import 'package:order_tracker/screens/login/email_signup_viewmodel.dart';
import 'package:order_tracker/widgets/login/error_state.dart';
import 'package:order_tracker/widgets/login/signup_form.dart';
import 'package:order_tracker/widgets/shared/view_model_widget.dart';

class EmailSignupView extends StatelessWidget {
  const EmailSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelScreenWrapper<EmailSignupViewModel,
        AsyncValue<EmailSignupViewState>>(
      viewModel: (context) => EmailSignupViewModel(),
      appBar: AppBar(),
      child: (context, state) {
        return state.when(
          isLoading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          hasError: (message) => LoginErrorState(
            message: message,
            clearFunction: context.read<EmailSignupViewModel>().clearError,
          ),
          hasData: (data) => const SignupForm(),
        );
      },
    );
  }
}
