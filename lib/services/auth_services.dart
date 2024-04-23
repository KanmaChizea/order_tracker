import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:order_tracker/main.dart';
import 'package:order_tracker/model/user.dart';

abstract interface class IAuthService {
  Future<User?> getInitialState();
  Stream<User?> authState();
  Future<User?> loginWithGithub();
  Future<User?> loginWithGoogle();
  Future<void> logout();
  Future<User> loginWithEmailAndPassword(String email, String password);
  Future<User> signup(String name, String email, String password);
}

class AuthService implements IAuthService {
  final _firebaseAuth = fb.FirebaseAuth.instance;

  @override
  Stream<User?> authState() {
    return _firebaseAuth
        .authStateChanges()
        .map((event) => event != null ? User.fromFirebase(event) : null);
  }

  @override
  Future<User?> loginWithGithub() async {
    late fb.UserCredential firebaseCredential;
    if (kIsWeb) {
      fb.GithubAuthProvider githubProvider = fb.GithubAuthProvider();
      firebaseCredential = await _firebaseAuth.signInWithPopup(githubProvider);
    } else {
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: dotenv.env['GH_CLIENT_ID'] as String,
          clientSecret: dotenv.env['GH_CLIENT_SECRET'] as String,
          redirectUrl: dotenv.env['GH_REDIRECT_URL'] as String);
      final result = await gitHubSignIn.signIn(navigatorKey.currentContext!);

      final githubAuthCredential =
          fb.GithubAuthProvider.credential(result.token ?? '');
      firebaseCredential =
          await _firebaseAuth.signInWithCredential(githubAuthCredential);
    }
    if (firebaseCredential.user != null) {
      return User.fromFirebase(firebaseCredential.user!);
    }

    return null;
  }

  @override
  Future<User?> loginWithGoogle() async {
    late fb.UserCredential firebaseCredential;
    if (kIsWeb) {
      fb.GoogleAuthProvider googleProvider = fb.GoogleAuthProvider();
      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
      firebaseCredential = await _firebaseAuth.signInWithPopup(googleProvider);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = fb.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      firebaseCredential =
          await fb.FirebaseAuth.instance.signInWithCredential(credential);
    }
    if (firebaseCredential.user != null) {
      return User.fromFirebase(firebaseCredential.user!);
    }

    return null;
  }

  @override
  Future<User?> getInitialState() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return User.fromFirebase(firebaseUser);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<User> signup(String name, String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await userCredential.user!.reload();
      }
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return User.fromFirebase(user);
      } else {
        throw Exception('Error logging in');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      return User.fromFirebase(userCredential.user!);
    } else {
      throw Exception('Error logging in');
    }
  }
}
