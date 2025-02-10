import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_job_tracker_app/viewmodel/verification_viewmodel.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignUpViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneRegex = RegExp(r'^\+61\d{9}$');

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Sign up using email, password, and phone number
  Future<void> signUp(BuildContext context, String name, String email,
      String password, String phoneNumber) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        phoneNumber.isEmpty) {
      _setError('Please enter all fields');
      return;
    }

    if (!phoneRegex.hasMatch(phoneNumber)) {
      Get.snackbar(
        'Invalid Phone Number',
        'Please enter a valid phone number in the format +61XXXXXXXXX.',
      );
      return;
    }

    _setLoading(true);

    try {
      // Create user with email & password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Update user's display name
        await user.updateDisplayName(name);

        // Link phone number with Firebase authentication
        await _verifyAndLinkPhoneNumber(context, user, phoneNumber);
        print("Starting to link User with Phone Number.");
      }

      _setError(null); // Clear error on success
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Function to verify and link phone number to user
  Future<void> _verifyAndLinkPhoneNumber(
      BuildContext context, User user, String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await user.linkWithCredential(credential);
          print("Phone number linked successfully.");
        },
        verificationFailed: (FirebaseAuthException e) {
          _setLoading(false);
          print("Phone verification failed: ${e.message}");
          Get.snackbar("Error", e.message ?? "Phone verification failed.");
        },
        codeSent: (String verificationId, int? resendToken) async {
          Provider.of<VerificationViewModel>(context, listen: false)
              .setVerificationId(verificationId); // Store verification ID
          print("OTP Sent! _verificationId = $verificationId");
          _setLoading(false);

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
      _setLoading(false);
      print("Error linking phone number: $e");
      Get.snackbar("Error", "Failed to link phone number.");
    }
  }

  Future<void> verifyOTP(BuildContext context, String otp) async {
    final user = FirebaseAuth.instance.currentUser;
    final verificationId =
        Provider.of<VerificationViewModel>(context, listen: false)
            .verificationId;
    print("Debug: _verificationId before verifying OTP: $verificationId");

    if (verificationId == null) {
      print("_verificationId is NULL. Cannot verify OTP.");
      Get.snackbar('Error', 'Verification ID is null. Please resend OTP.');
      return;
    }

    // Check if the phone number is already linked
    if (user?.phoneNumber != null) {
      print("⚠️ Phone number is already linked: ${user?.phoneNumber}");
      context.go('/home'); // Skip linking and go to home
      return;
    }

    _setLoading(true);
    print("Started verifyOTP with code: $otp");

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      print("Signing in with OTP...");
      UserCredential userCredential = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credential);

      print("Firebase sign-in completed!");

      print("Checking if userCredential.user is not null...");
      if (userCredential.user != null) {
        print("User exists. Proceeding with navigation...");
        Future.delayed(Duration(milliseconds: 200), () {
          if (context.mounted) {
            print("Context is still mounted. Navigating now...");
            GoRouter.of(context).go('/home');
            print("Navigation function executed!");
            _setLoading(false);
          } else {
            print("Navigation failed: Context is unmounted.");
          }
        });
      } else {
        print("userCredential.user is NULL. Navigation skipped.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'provider-already-linked') {
        print("Phone number is already linked. Redirecting...");
        GoRouter.of(context).go('/home'); // If already linked, navigate home
      }
      print("FirebaseAuthException: ${e.message}");
      Get.snackbar('Error Occurred', e.message ?? 'Invalid OTP');
    } catch (e) {
      print("General Exception: $e");
      Get.snackbar('Error Occurred', e.toString());
    } finally {
      print("Resetting loading state...");
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
