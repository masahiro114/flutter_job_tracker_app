import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/model/signin_model.dart';
import 'package:flutter_job_tracker_app/viewmodel/verification_viewmodel.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInViewModel extends ChangeNotifier {
  final SignInModel _signInModel = SignInModel();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? get userPhoneNumber => FirebaseAuth.instance.currentUser?.phoneNumber;

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
        print("User signed in! Sending OTP!");
        sendLoginOTP(context);
        //context.go("/otp");
        return null; // Sign-in successful
      }
    } catch (e) {
      return e.toString();
    } finally {
      setLoading(false);
    }
    return 'Sign-in failed';
  }

  Future<void> sendLoginOTP(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          //FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setLoading(false);
          print("Phone verification failed: ${e.message}");
          Get.snackbar("Error", e.message ?? "Phone verification failed.");
        },
        codeSent: (String verificationId, int? resendToken) async {
          Provider.of<VerificationViewModel>(context, listen: false)
              .setVerificationId(verificationId); // Store verification ID
          print("OTP Sent! _verificationId = $verificationId");
          setLoading(false);

          // Navigate to OTP screen
          context.go('/otp');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Provider.of<VerificationViewModel>(context, listen: false)
              .setVerificationId(
                  verificationId); // Store verification ID even on timeout
          Get.snackbar(
              'OTP Timeout', 'Auto-retrieval failed. Enter OTP manually.');
          print("Auto-retrieval timeout. _verificationId = $verificationId");
        },
      );
    } catch (e) {
      setLoading(false);
      print("Error linking phone number: $e");
      Get.snackbar("Error", "Failed to link phone number.");
    }
  }
}
