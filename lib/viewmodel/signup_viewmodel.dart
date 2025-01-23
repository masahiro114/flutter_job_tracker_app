import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Sign up using email and password
  Future<void> signUp(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _setError('Please enter all fields');
      return;
    }

    _setLoading(true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _setError(null); // Clear error on success
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }



  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
