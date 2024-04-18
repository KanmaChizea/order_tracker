import 'package:firebase_auth/firebase_auth.dart' as fb;

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  factory User.fromFirebase(fb.User firebaseUser) {
    return User(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
    );
  }

  String getFirstName() {
    return name.split(' ')[0];
  }
}
