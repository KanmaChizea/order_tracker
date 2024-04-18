import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/core/dependency_injection/injection_container.dart';
import 'package:order_tracker/model/auth_states.dart';
import 'package:order_tracker/services/auth_services.dart';

enum SocialLoginMethod { google, github }

class UserCubit extends Cubit<AuthState> {
  UserCubit() : super(UserNotSignedIn()) {
    initialize();
  }

  final _authService = sl.get<IAuthService>();

  void initialize() async {
    final initialState = await _authService.getInitialState();
    if (initialState != null) {
      emit(UserSignedIn(initialState));
    }
    listenToAuthStateUpdates();
  }

  void listenToAuthStateUpdates() {
    _authService.authState().listen((event) {
      if (event == null) {
        emit(UserNotSignedIn());
      } else {
        emit(UserSignedIn(event));
      }
    });
  }

  void loginWithSocials(SocialLoginMethod loginMethod) async {
    try {
      final user = switch (loginMethod) {
        SocialLoginMethod.google => await _authService.loginWithGoogle(),
        SocialLoginMethod.github => await _authService.loginWithGithub(),
      };
      if (user != null) {
        emit(UserSignedIn(user));
      } else {
        emit(UserNotSignedIn());
      }
    } catch (e) {
      emit(UserSignInFailed(errorMessage: e.toString()));
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    final user = await _authService.loginWithEmailAndPassword(email, password);
    emit(UserSignedIn(user));
  }

  Future<void> signup(String name, String email, String password) async {
    final user = await _authService.signup(name, email, password);
    emit(UserSignedIn(user));
  }

  void logout() async {
    await _authService.logout();
    emit(UserNotSignedIn());
  }
}
