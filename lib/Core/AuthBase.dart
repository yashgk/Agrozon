import 'package:firebase_auth/firebase_auth.dart';
abstract class AuthBase {
  User get currentUser;
  Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  User get currentUser => FirebaseAuth.instance.currentUser;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithGoogle() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }
  
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
