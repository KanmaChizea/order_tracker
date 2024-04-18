import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/firebase_options.dart';
import 'package:order_tracker/model/auth_states.dart';
import 'package:order_tracker/model/order.dart';
import 'package:order_tracker/theme/themes.dart';
import 'package:order_tracker/widgets/shared/delivered_modal.dart';

import 'core/cubits/theme_cubit.dart';
import 'navigation/routes.dart';
import 'core/dependency_injection/injection_container.dart' as di;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  di.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl.get<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl.get<UserCubit>(),
        ),
        BlocProvider(
          create: (_) => di.sl.get<OrderCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserCubit, AuthState>(
            listener: (context, state) {
              if (state is UserSignedIn) {
                context.read<OrderCubit>().initializeTracking();
              } else {
                context.read<OrderCubit>().stopTracking();
              }
              navigatorKey.currentState!.pushNamedAndRemoveUntil(
                state is UserSignedIn ? '/home' : '/login',
                (_) => false,
              );
            },
          ),
          BlocListener<OrderCubit, Order?>(listener: (context, state) {
            if (state != null && state.status == OrderStatus.delivered) {
              showAdaptiveDialog(
                context: navigatorKey.currentContext!,
                barrierDismissible: false,
                builder: (context) => const OrderDeliveredModal(),
              );
            }
          }),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
              title: 'Edyn Life',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: context.watch<ThemeCubit>().state,
              navigatorKey: navigatorKey,
              initialRoute: context.watch<UserCubit>().state is UserSignedIn
                  ? '/home'
                  : '/login',
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
