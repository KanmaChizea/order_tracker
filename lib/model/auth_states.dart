import 'package:order_tracker/model/user.dart';

sealed class AuthState {}

class UserSignedIn extends AuthState {
  UserSignedIn(this.user);
  final User user;
}

class UserNotSignedIn extends AuthState {}

class UserSignInFailed extends AuthState {
  UserSignInFailed({
    required this.errorMessage,
  });
  final String errorMessage;
}
