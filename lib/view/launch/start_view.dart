import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/viewmodel/start_viewmodel.dart';
import 'package:flutter_job_tracker_app/model/start_model.dart';
import 'package:flutter_job_tracker_app/view/common/background_widget.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
    // Create ViewModel using the default data
    final viewModel = StartPageViewModel(
      model: StartPageModel.defaultData(),
    );

    return Scaffold(
      body: GlobalBackground(
        // Content Layer (Text and Button)
        child: Center(
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
                  viewModel.model.title,
                  style: _textStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 20),
                // Subtitle Text
                Text(
                  viewModel.model.subtitle,
                  style: _textStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Start Button
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.onContinueToSignUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      'Sign up with Email',
                      style: _textStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,  // Width of the container
                  height: 5,  // Height of the container (typically you'd want a higher value for visibility)
                  decoration: BoxDecoration(
                    border: const Border(
                      top: const BorderSide(
                        color: Colors.white,  // White border color
                        width: 1.0,  // Border width
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: SignInButton(
                    Buttons.Email,
                    onPressed: () {
                      viewModel.onSignIn(context);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Google Sign-In Button using flutter_signin_button
                SizedBox(
                  width: double.infinity,
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () async {
                      await viewModel.onGoogleSignIn(context);
                    },
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
