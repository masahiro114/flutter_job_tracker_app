import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/model/tracking_model.dart';

class TrackingPageViewModel extends ChangeNotifier {
  final TrackingPageModel model;

  TrackingPageViewModel({required this.model});

  // Simulate business logic like navigating to the next page
  void onNextButtonPressed(BuildContext context) {
    // Handle the button press and navigate to the next page
    context.go('/comparison');
  }

  void onSignInButtonPressed(BuildContext context) {
    // Navigate to the sign-in page
    context.go('/signin');
  }
}
