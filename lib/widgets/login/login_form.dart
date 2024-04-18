import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/screens/login/email_login_view_model.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';
import 'package:order_tracker/utils/validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EmailLoginViewModel>().state.data;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            AppSpacing.space(8),
            const Text(
              'Enter your email and passowrd and start ordering!',
              style: AppTextstyles.subHeading,
            ),
            AppSpacing.space(40),
            TextFormField(
              controller: emailController,
              validator: Validator.email,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            AppSpacing.space(32),
            TextFormField(
              controller: passwordController,
              obscureText: !(state?.passwordVisible ?? false),
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed:
                      context.read<EmailLoginViewModel>().toggleVisibility,
                  icon: Icon(
                    state?.passwordVisible ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            AppSpacing.space(64),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context
                      .read<EmailLoginViewModel>()
                      .login(emailController.text, passwordController.text);
                }
              },
              child: const Text('Login'),
            ),
            AppSpacing.space(24),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Don\'t have an account? ',
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            context.read<EmailLoginViewModel>().goToSignup,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
