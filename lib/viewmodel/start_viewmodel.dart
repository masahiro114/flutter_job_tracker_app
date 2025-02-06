import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/model/start_model.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign-In package
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class StartPageViewModel extends ChangeNotifier {
  final StartPageModel model;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  StartPageViewModel({required this.model});

  // Navigate to Tracking page
  void onContinueToSignUp(BuildContext context) {
    // Navigate to the sign-up page for new users
    context.go('/signup');
  }

  // Navigate to Sign-In page
  void onSignIn(BuildContext context) {
    // Navigate to the sign-in page
    context.go('/signin');
  }

  // Handle Google Sign-In
  Future<void> onGoogleSignIn(BuildContext context) async {
    _setLoading(true);

    try {
      print("start");
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      print("user: ${googleUser}");

      if (googleUser == null) {
        _setError('Google sign-in aborted by user');
        _setLoading(false);
        return;
      }

      // Get the authentication details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new Firebase credential from Google sign-in
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Check if user is newly signed up or existing
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        // Handle new user sign-up
        print("New user, navigating to home...");
        context.go('/home'); // Navigate to home page for new user
      } else {
        // Handle existing user sign-in
        print("Existing user, navigating to home...");
        context.go('/home'); // Navigate to home page for existing user
      }

      _setError(null); // Clear any errors on success
    } catch (e) {
      _setError('Google sign-in failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  // Helper method to set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Helper method to set error message
  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
