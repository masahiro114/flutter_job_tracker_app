// comparison_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/model/comparison_model.dart';

class ComparisonPageViewModel extends ChangeNotifier {
  final ComparisonPageModel model;

  ComparisonPageViewModel({required this.model});

  // Method to handle button press for "Next"
  void onNextButtonPressed(BuildContext context) {
    // Simulate navigation to the signup page
    context.go('/signup');
  }

  // Method to handle button press for "Sign in"
  void onSignInButtonPressed(BuildContext context) {
    // Simulate navigation to the sign-in page
    context.go('/signin');
  }
}
