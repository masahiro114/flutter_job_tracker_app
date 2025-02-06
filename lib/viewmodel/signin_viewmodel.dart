import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/model/signin_model.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignInViewModel extends ChangeNotifier {
  final SignInModel _signInModel = SignInModel();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _verificationId;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> signIn(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    setLoading(true);

    try {
      final userCredential = await _signInModel.signIn(email, password);
      if (userCredential != null) {
        context.go("/home");
        return null; // Sign-in successful
      }
    } catch (e) {
      return e.toString();
    } finally {
      setLoading(false);
    }
    return 'Sign-in failed';
  }
}
