import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:order_tracker/screens/login/login_viewmodel.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/widgets/shared/view_model_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelScreenWrapper<LoginViewModel, bool>(
      viewModel: (context) => LoginViewModel(),
      child: (context, isLoading) {
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Builder(
          builder: (context) {
            return Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  const Text(
                    'Edyn Life',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Lottie.asset(
                      'lib/assets/animations/delivery.json',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: context.read<LoginViewModel>().loginWithGoogle,
                    label: const Text(
                      'Continue with Google',
                    ),
                    icon: SvgPicture.asset(
                      'lib/assets/svgs/google.svg',
                    ),
                  ),
                  AppSpacing.space(32),
                  OutlinedButton.icon(
                    onPressed: context.read<LoginViewModel>().loginWithGithub,
                    label: const Text(
                      'Continue with Github',
                    ),
                    icon: SvgPicture.asset(
                      'lib/assets/svgs/github.svg',
                      colorFilter:
                          Theme.of(context).brightness == Brightness.dark
                              ? const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                )
                              : null,
                    ),
                  ),
                  AppSpacing.space(32),
                  OutlinedButton.icon(
                    onPressed: context.read<LoginViewModel>().goToEmailLogin,
                    label: const Text(
                      'Continue with Email',
                    ),
                    icon: SvgPicture.asset(
                      'lib/assets/svgs/email.svg',
                      height: 24,
                    ),
                  ),
                  AppSpacing.space(42),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
