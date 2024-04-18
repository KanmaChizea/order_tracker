import 'package:firebase_auth/firebase_auth.dart';

abstract class AppError {
  static String getErrorMessage(Object error) {
    if (error is FirebaseAuthException) {
      return error.message ?? 'Something went wrong';
    }
    //handle other errors

    return 'Someting went wrong';
  }
}
