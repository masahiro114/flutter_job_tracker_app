import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For using ChangeNotifierProvider
import 'package:flutter_job_tracker_app/viewmodel/profile_viewmodel.dart'; // Import ViewModel
import 'package:flutter_job_tracker_app/view/common/navigation_widget.dart'; // Reusable BottomNavigationBar
import 'package:flutter_job_tracker_app/view/common/background_widget.dart'; // Global Background

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: Scaffold(
        bottomNavigationBar: Consumer<ProfileViewModel>(
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
        body: GlobalBackground(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Profile',
                    style: _textStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger the sign-out process when the button is pressed
                      Provider.of<ProfileViewModel>(context, listen: false).signOut(context);
                    },
                    child: Text(
                      'Sign Out',
                      style: _textStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
