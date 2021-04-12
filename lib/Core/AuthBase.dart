import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  User get currentUser;
  Future<void> signInWithPhone(String number);
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

  Future<void> signInWithPhone(String number) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("phone verification failed");
      },
      codeSent: (String verificationId, int resendToken) {
        print("code sent");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("code auto retrival timeout");
      },
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
