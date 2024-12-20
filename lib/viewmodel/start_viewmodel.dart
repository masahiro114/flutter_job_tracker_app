import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/model/start_model.dart';

class StartPageViewModel extends ChangeNotifier {
  final StartPageModel model;

  StartPageViewModel({required this.model});

  // Simulate business logic, such as navigation or state changes
  void onContinueToSignUp(BuildContext context) {
    // Handle the button press logic, like navigation
    context.go('/tracking');
  }

  void onSignIn(BuildContext context) {
    // Handle sign-in button logic
    context.go('/signin');
  }
}
