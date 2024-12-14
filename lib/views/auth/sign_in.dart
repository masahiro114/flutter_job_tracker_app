import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  // Extracted reusable text style for consistency
  TextStyle _textStyle({
    Color color = Colors.white,
    double fontSize = 17,
    FontWeight fontWeight = FontWeight.w400,
    double height = 0.08,
    double letterSpacing = -0.43,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background colour
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF57C7DB), Color(0xFF0309C8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              top: -200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/background_icon.png'), // Correct asset path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Content Layer (Text and Button)
            Center(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Text
                    Text(
                      'Job Tracker',
                      style: _textStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Subtitle Text
                    Text(
                      'Your path to career success, tracked and managed.',
                      style: _textStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.5,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Start Button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _registerText(),
                        const SizedBox(height: 40),
                        _emailField(context),
                        const SizedBox(height: 20),
                        _passwordField(context),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              // Testing Sign Up Button
                              Fluttertoast.showToast(
                                  msg: "Signing In",
                                  gravity: ToastGravity.BOTTOM);
                            },
                            child: Text(
                              'Sign In',
                              style: _textStyle(
                                  color: Color(0xFF0309C8),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Enter Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
