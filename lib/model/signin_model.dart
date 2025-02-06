import 'package:firebase_auth/firebase_auth.dart';

class SignInModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User: ${userCredential.user?.uid}");
      return userCredential;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
