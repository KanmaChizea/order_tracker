import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/cubits/theme_cubit.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/model/auth_states.dart';
import 'package:order_tracker/screens/home/home_view_model.dart';

class ActionMenu extends StatelessWidget {
  const ActionMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final user = (context.watch<UserCubit>().state as UserSignedIn).user;
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(
            context.watch<ThemeCubit>().state == ThemeMode.light
                ? Colors.teal.shade50
                : Colors.grey.shade700),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: CircleAvatar(
            foregroundImage:
                user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
            radius: 15,
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          onPressed: context.read<HomeViewModel>().goToProfile,
          child: const Text('View profile'),
        ),
        MenuItemButton(
          onPressed: context.read<HomeViewModel>().switchThemes,
          child: const Text('Switch theme'),
        ),
        MenuItemButton(
          onPressed: context.read<HomeViewModel>().logout,
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
