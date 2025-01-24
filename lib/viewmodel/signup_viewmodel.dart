import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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
      print('SignUp Error: One or more fields are empty.');
      return;
    }

    _setLoading(true);
    print('SignUp: Started sign-up process.');

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('SignUp: User created successfully.');

      final viewModel = SignUpViewModel();
      viewModel.testReload();

      _setError(null); // Clear error on success
      print('SignUp: Sending verification link...');
      await _sendVerifyLink(); // Send verification link after sign-up

      // Wait for email verification
      print('SignUp: Waiting for email verification...');
      print(
          'SignUp: Waiting a few seconds for email verification propagation...');
      await Future.delayed(Duration(seconds: 10));
      print('SignUp: Starting email verification check...');

      final isVerified = await verifyEmail();
      if (!isVerified) {
        _setError('Email verification timed out.');
        print('SignUp: Email verification timed out.');
        return;
      }

      // Email verified - continue with other operations if needed
      print('SignUp: Email verified successfully.');
      Get.snackbar('Success', 'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      _setError('Sign-up failed: ${e.toString()}');
      print('SignUp Error: ${e.toString()}');
    } finally {
      _setLoading(false);
      print('SignUp: Process completed.');
    }
  }

  // Wait for email verification
  Future<bool> verifyEmail() async {
    print('VerifyEmail: Starting email verification process.');
    try {
      print('SignUp: Proceeding to waitForEmailVerification...');
      final isVerified = await waitForEmailVerification(
        checkInterval: Duration(seconds: 5),
        timeout: Duration(minutes: 5),
      );

      if (isVerified) {
        Get.snackbar('Success', 'Your email has been verified!',
            snackPosition: SnackPosition.BOTTOM);
        print('VerifyEmail: Email verified.');
      } else {
        print('VerifyEmail: Email verification timed out.');
        Get.snackbar('Timeout', 'Email verification timed out.',
            snackPosition: SnackPosition.BOTTOM);
      }
      return isVerified;
    } catch (e) {
      _setError('Error during email verification: ${e.toString()}');
      print('VerifyEmail Error: ${e.toString()}');
      return false;
    }
  }

  Future<void> _sendVerifyLink() async {
    final user = _auth.currentUser;
    if (user == null) {
      _setError('No user is currently signed in.');
      print('_sendVerifyLink Error: No user signed in.');
      return;
    }

    try {
      await user.sendEmailVerification();
      print('_sendVerifyLink: Verification link sent successfully.');
      Get.snackbar(
        'Link sent',
        'A verification link has been sent to your email.',
        margin: EdgeInsets.all(30),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('_sendVerifyLink Error: ${e.toString()}');
      _setError('Failed to send verification link: ${e.toString()}');
    }
  }

  Future<bool> waitForEmailVerification({
    Duration checkInterval = const Duration(seconds: 5),
    Duration timeout = const Duration(minutes: 20),
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('waitForEmailVerification: No user is signed in.');
      throw Exception('No user is currently signed in.');
    }

    final completer = Completer<bool>();
    final startTime = DateTime.now();

    Timer.periodic(checkInterval, (timer) async {
      print('waitForEmailVerification: Checking email verification status...');
      try {
        await user.reload(); // Fetch latest user data
        print('waitForEmailVerification: Reloaded user data.');

        if (user.emailVerified) {
          print('waitForEmailVerification: Email is verified!');
          timer.cancel();
          completer.complete(true);
        } else if (DateTime.now().difference(startTime) >= timeout) {
          print(
              'waitForEmailVerification: Timeout reached. Email not verified.');
          timer.cancel();
          completer.complete(false);
        } else {
          print('waitForEmailVerification: Email not verified yet.');
        }
      } catch (e) {
        print('waitForEmailVerification Error: ${e.toString()}');
        timer.cancel();
        completer.complete(false);
      }
    });

    return completer.future;
  }

  void testReload() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Before reload: emailVerified = ${user.emailVerified}');
      print('User email: ${user.email}');
      print('User UID: ${user.uid}');
      await user.reload();
      print('After reload: emailVerified = ${user.emailVerified}');
    } else {
      print('No user is signed in.');
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
