import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/viewmodel/tracking_viewmodel.dart';
import 'package:flutter_job_tracker_app/model/tracking_model.dart';
import 'package:flutter_job_tracker_app/view/common/background_widget.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

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
    // Create the ViewModel with the default data
    final viewModel = TrackingPageViewModel(
      model: TrackingPageModel.defaultData(),
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
                const SizedBox(height: 20),
                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.onNextButtonPressed(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      viewModel.model.buttonText,
                      style: _textStyle(
                        color: const Color(0xFF0309C8),
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    viewModel.onSignInButtonPressed(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Text(
                      'Sign in',
                      style: _textStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
