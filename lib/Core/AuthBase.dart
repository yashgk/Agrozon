import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Future<UserCredential> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  User get currentUser => FirebaseAuth.instance.currentUser;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  //   // Obtain the auth details from the request
  //   GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //   // Create a new credential
  //   GoogleAuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   // Once signed in, return the UserCredential
  //   return await signInWithCred(credential);
  // }
  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        UserCredential userCredential = await firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential;
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
  }

  Future<UserCredential> signInWithCred(AuthCredential credential) async {
    return await firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
