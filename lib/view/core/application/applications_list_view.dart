import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For ChangeNotifierProvider
import 'package:flutter_job_tracker_app/viewmodel/application_viewmodel.dart'; // Import ViewModel
import 'package:flutter_job_tracker_app/view/common/navigation_widget.dart'; // Reusable BottomNavigationBar
import 'package:flutter_job_tracker_app/view/common/background_widget.dart'; // Global Background
import 'package:go_router/go_router.dart'; // Assuming you're using GoRouter for navigation

class ApplicationsPage extends StatelessWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationViewModel(), // Provide the ViewModel
      child: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: Consumer<ApplicationViewModel>(
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
                  // Title Text
                  Text(
                    'Applications',
                    style: _textStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 100),
                  // List of application buttons
                  _applicationButton(context, 'Application 1', '/applications/1'),
                  const SizedBox(height: 20),
                  _applicationButton(context, 'Application 2', '/applications/2'),
                  const SizedBox(height: 20),
                  _applicationButton(context, 'Application 3', '/applications/3'),
                  const SizedBox(height: 20),
                  _applicationButton(context, 'Application 4', '/applications/4'),
                  const SizedBox(height: 20),
                  _applicationButton(context, 'Application 5', '/applications/5'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable Application Button
  Widget _applicationButton(BuildContext context, String label, String route) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the specific application page using context
          context.go(route);
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

  // Reusable text style for consistency
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
