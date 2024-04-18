import 'package:get_it/get_it.dart';
import 'package:order_tracker/core/cubits/order_cubit.dart';
import 'package:order_tracker/core/cubits/theme_cubit.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/main.dart';
import 'package:order_tracker/navigation/navigation_service.dart';
import 'package:order_tracker/services/ably.dart';
import 'package:order_tracker/services/auth_services.dart';
import 'package:order_tracker/services/secure_storage.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<IAuthService>(() => AuthService());
  sl.registerLazySingleton<AblyService>(() => AblyService());

  sl.registerLazySingleton<UserCubit>(() => UserCubit());
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<OrderCubit>(() => OrderCubit());

  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());

  sl.registerLazySingleton<NavigationService>(
    () => NavigationService(navigatorKey: navigatorKey),
  );
}
