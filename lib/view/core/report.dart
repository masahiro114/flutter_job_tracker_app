import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For using ChangeNotifierProvider
import 'package:flutter_job_tracker_app/viewmodel/report_viewmodel.dart'; // Import ViewModel
import 'package:flutter_job_tracker_app/view/common/navigation_widget.dart'; // Reusable BottomNavigationBar
import 'package:flutter_job_tracker_app/view/common/background_widget.dart'; // Global Background

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportViewModel(),
      child: Scaffold(
        // Bottom Navigation Bar
        bottomNavigationBar: Consumer<ReportViewModel>(
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
                    'Report',
                    style: _textStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
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
