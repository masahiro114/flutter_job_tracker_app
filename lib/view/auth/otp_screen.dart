import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/view/common/background_widget.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_job_tracker_app/viewmodel/signin_viewmodel.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _otpCode = '';

  // Reusable text style
  TextStyle _textStyle({
    Color color = Colors.white,
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final signInViewModel = context.watch<SignInViewModel>();

    return Scaffold(
      body: GlobalBackground(
        child: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verify OTP",
                  style: _textStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Enter the 6-digit OTP sent to your phone.",
                  textAlign: TextAlign.center,
                  style: _textStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30.0),
                OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields: 6,
                  borderColor: Colors.grey,
                  onSubmit: (code) {
                    setState(() {
                      _otpCode = code;
                    });
                  },
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_otpCode.isEmpty || _otpCode.length < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please enter a valid OTP")),
                        );
                        return;
                      }
                      signInViewModel.verifyOTP(context, _otpCode);
                    },
                    child: signInViewModel.isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Verify OTP"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
