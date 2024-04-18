import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/cubits/theme_cubit.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/navigation/navigation_service.dart';

class HomeViewModel extends Cubit<void> {
  HomeViewModel() : super(null);

  final _userCubit = sl.get<UserCubit>();
  final _themeCubit = sl.get<ThemeCubit>();
  final _navigator = sl.get<NavigationService>();

  void logout() => _userCubit.logout();
  void switchThemes() => _themeCubit.toggleTheme();
  void goToProfile() => _navigator.navigate('/profile');
  void goToTrackOrder() => _navigator.navigate('/track_order');
}
