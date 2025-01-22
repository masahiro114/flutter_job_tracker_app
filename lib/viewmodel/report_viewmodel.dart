import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportViewModel extends ChangeNotifier {
  // Bottom navigation selected index
  int _currentState = 2;

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
    } else if (_currentState == 3) {
      context.go('/profile');
    }
  }
}
