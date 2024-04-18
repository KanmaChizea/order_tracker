import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/cubits/user_cubit.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/model/async_value.dart';

class EmailSignupViewState {
  EmailSignupViewState({
    required this.passwordVisible,
    required this.confirmPasswordVisible,
  });

  final bool passwordVisible;
  final bool confirmPasswordVisible;

  factory EmailSignupViewState.initial() {
    return EmailSignupViewState(
        passwordVisible: false, confirmPasswordVisible: false);
  }

  EmailSignupViewState copyWith({
    bool? passwordVisible,
    bool? confirmPasswordVisible,
  }) {
    return EmailSignupViewState(
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
    );
  }
}

class EmailSignupViewModel extends Cubit<AsyncValue<EmailSignupViewState>> {
  EmailSignupViewModel()
      : super(
          AsyncValue.data(
            EmailSignupViewState.initial(),
          ),
        );

  final _userCubit = sl.get<UserCubit>();

  void signup(String name, String email, String password) async {
    emit(AsyncValue.loading());
    try {
      await _userCubit.signup(name, email, password);
    } catch (e) {
      emit(
        AsyncValue.error(e),
      );
    }
  }

  void togglePasswordVisibility() {
    if (state.isdata) {
      emit(
        AsyncValue.data(state.data!
            .copyWith(passwordVisible: !state.data!.passwordVisible)),
      );
    }
  }

  void toggleConfirmPasswordVisibility() {
    if (state.isdata) {
      emit(
        AsyncValue.data(state.data!.copyWith(
            confirmPasswordVisible: !state.data!.confirmPasswordVisible)),
      );
    }
  }

  void clearError() => emit(
        AsyncValue.data(EmailSignupViewState.initial()),
      );
}
