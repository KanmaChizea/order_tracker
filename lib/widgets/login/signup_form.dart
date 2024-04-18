import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/screens/login/email_signup_viewmodel.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';
import 'package:order_tracker/utils/validator.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController confirmPasswordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EmailSignupViewModel>().state.data ??
        EmailSignupViewState.initial();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Signup',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            AppSpacing.space(8),
            const Text(
              'Fill the form to create an account and start ordering!',
              style: AppTextstyles.subHeading,
            ),
            AppSpacing.space(40),
            TextFormField(
              controller: nameController,
              validator: Validator.required,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            AppSpacing.space(32),
            TextFormField(
              controller: emailController,
              validator: Validator.email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            AppSpacing.space(32),
            TextFormField(
              controller: passwordController,
              validator: Validator.strongPassword,
              obscureText: !state.passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: context
                      .read<EmailSignupViewModel>()
                      .togglePasswordVisibility,
                  icon: Icon(
                    state.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            AppSpacing.space(32),
            TextFormField(
              controller: confirmPasswordController,
              validator: (value) => Validator.sameAs(
                value,
                passwordController.text,
                'Passwords dont match',
              ),
              obscureText: !state.confirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                suffixIcon: IconButton(
                  onPressed: context
                      .read<EmailSignupViewModel>()
                      .toggleConfirmPasswordVisibility,
                  icon: Icon(
                    state.confirmPasswordVisible
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
                  context.read<EmailSignupViewModel>().signup(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                }
              },
              child: const Text('Signup'),
            ),
            AppSpacing.space(24),
          ],
        ),
      ),
    );
  }
}
