import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/model/auth_states.dart';
import 'package:order_tracker/theme/spacing.dart';
import 'package:order_tracker/theme/textstyles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<UserCubit>().state as UserSignedIn).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 65,
                foregroundImage:
                    user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
              ),
            ),
            AppSpacing.space(32),
            Text(
              'Name: ${user.name}',
              style: AppTextstyles.bodyBig,
            ),
            AppSpacing.space(8),
            Text(
              'Email: ${user.email}',
              style: AppTextstyles.bodyBig,
            ),
            AppSpacing.space(8),
          ],
        ),
      ),
    );
  }
}
