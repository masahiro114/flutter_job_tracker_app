import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/model/signin_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class SignInViewModel extends ChangeNotifier {
  final SignInModel _signInModel = SignInModel();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _verificationId;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String?> signIn(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String phoneNumber = phoneNumberController.text.trim();

    setLoading(true);

    try {
      final userCredential = await _signInModel.signIn(email, password);
      if (userCredential != null) {
        return null; // Sign-in successful
      }
    } catch (e) {
      return e.toString();
    } finally {
      setLoading(false);
    }
    return 'Sign-in failed';
  }

  Future<void> sendOTP(BuildContext context, phoneNumber) async {
    final phoneRegex = RegExp(r'^\+61\d{9}$');

    if (phoneNumber.isEmpty || !phoneRegex.hasMatch(phoneNumber)) {
      Get.snackbar('Invalid Phone Number',
          'Please enter a valid phone number in the format +61XXXXXXXXX.');
      return;
    }

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) {
            //FirebaseAuth.instance.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error Ocurred', e.code);
          },
          codeSent: (String vid, int? token) {
            _verificationId = vid;
            context.go('/otp');
          },
          codeAutoRetrievalTimeout: (vid) {
            _verificationId = vid;
          });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Ocurred', e.code);
    } catch (e) {
      Get.snackbar('Error Ocurred', e.toString());
    }
  }

  Future<void> verifyOTP(BuildContext context, String otp) async {
    if (_verificationId == null) {
      Get.snackbar('Error', 'Verification ID is null. Please resend OTP.');
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Get.snackbar('Success', 'Phone number verified successfully!');
        context.go('/home');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occurred', e.message ?? 'Invalid OTP');
    } catch (e) {
      Get.snackbar('Error Occurred', e.toString());
    }
  }
}
