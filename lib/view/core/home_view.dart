import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_job_tracker_app/viewmodel/home_viewmodel.dart'; // Import ViewModel
import 'package:flutter_job_tracker_app/view/common/navigation_widget.dart'; // Reusable BottomNavigationBar
import 'package:flutter_job_tracker_app/view/common/background_widget.dart'; // Global Background

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return GlobalNavigationBar(
              currentIndex: viewModel.currentState,
              onItemTapped: (index) {
                viewModel.updateNavIndex(index);
                viewModel.onNavBarPressed(context);
              },
            );
          },
        ),
        // Background and Content
        body: GlobalBackground(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Recent Applications',
                    style: _textStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 100),
                  _applicationButton('Application 1'),
                  const SizedBox(height: 20),
                  _applicationButton('Application 2'),
                  const SizedBox(height: 20),
                  _applicationButton('Application 3'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Application Button
  Widget _applicationButton(String label) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press logic (e.g., navigation to specific app)
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Text(
          label,
          style: _textStyle(
            color: const Color(0xFF0309C8),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

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
}
