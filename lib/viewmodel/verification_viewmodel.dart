import 'package:flutter/material.dart';

class VerificationViewModel extends ChangeNotifier {
  String? _verificationId;

  String? get verificationId => _verificationId;

  void setVerificationId(String id) {
    _verificationId = id;
    notifyListeners();
  }
}
