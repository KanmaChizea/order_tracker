import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/navigation/navigation_service.dart';

/// boolean state value represents loading state of the screen
class LoginViewModel extends Cubit<bool> {
  LoginViewModel() : super(false);

  final _navigator = sl.get<NavigationService>();
  final _userCubit = sl.get<UserCubit>();

  void goToEmailLogin() => _navigator.navigate('/email_login');

  void loginWithGithub() {
    emit(true);
    _userCubit.loginWithSocials(SocialLoginMethod.github);
    emit(false);
  }

  void loginWithGoogle() {
    emit(true);
    _userCubit.loginWithSocials(SocialLoginMethod.google);
    emit(false);
  }
}
