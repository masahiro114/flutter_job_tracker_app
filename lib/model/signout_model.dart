import 'package:firebase_auth/firebase_auth.dart';

class SignOutModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      print('Attempting to sign out...');
      await _auth.signOut();
      print('Sign-out successful');
    } catch (e) {
      //print('Sign-out failed: $e');
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }
}
