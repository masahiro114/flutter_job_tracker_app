import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/model/signout_model.dart';

class ProfileViewModel extends ChangeNotifier {
  // Create an instance of SignOutModel
  final SignOutModel _signOutModel = SignOutModel(); // Instantiate SignOutModel

  // Bottom navigation selected index
  int _currentState = 3;

  // Getter for current state
  int get currentState => _currentState;

  // Method to update the selected index
  void updateNavIndex(int index) {
    _currentState = index;
    notifyListeners(); // Notify listeners when state changes
  }

  // Method to handle navigation when an item is tapped
  void onNavBarPressed(BuildContext context) {
    if (_currentState == 1) {
      context.go('/applications');
    } else if (_currentState == 2) {
      context.go('/report');
    } else if (_currentState == 0) {
      context.go('/home');
    }
  }

  // Sign-out method
  Future<void> signOut(BuildContext context) async {
    try {
      // Call the sign-out method from SignOutModel
      await _signOutModel.signOut();

      // Navigate to the sign-in page after sign-out
      context.go('/'); // Adjust based on your app's route name
    } catch (e) {
      // Show an error message if sign-out fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-out failed: $e')),
      );
    }
  }
}
