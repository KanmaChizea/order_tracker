import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/model/async_value.dart';
import 'package:order_tracker/navigation/navigation_service.dart';

class EmailLoginViewState {
  EmailLoginViewState({
    required this.passwordVisible,
  });

  final bool passwordVisible;
}

class EmailLoginViewModel extends Cubit<AsyncValue<EmailLoginViewState>> {
  EmailLoginViewModel()
      : super(
          AsyncValue.data(
            EmailLoginViewState(
              passwordVisible: false,
            ),
          ),
        );

  final _userCubit = sl.get<UserCubit>();
  final _navigator = sl.get<NavigationService>();

  void login(String email, String password) async {
    emit(AsyncValue.loading());
    try {
      await _userCubit.loginWithEmailAndPassword(email, password);
    } catch (e) {
      emit(
        AsyncValue.error(e),
      );
    }
  }

  void toggleVisibility() {
    if (state.isdata) {
      emit(
        AsyncValue.data(
          EmailLoginViewState(
            passwordVisible: !state.data!.passwordVisible,
          ),
        ),
      );
    }
  }

  void clearError() => emit(
        AsyncValue.data(
          EmailLoginViewState(
            passwordVisible: false,
          ),
        ),
      );

  void goToSignup() => _navigator.navigate('/email_signup');
}
