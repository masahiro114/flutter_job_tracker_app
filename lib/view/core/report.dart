import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/view/common/background_widget.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
  }

  // NavBar selected item state
  int _currentState = 2;

  // NavBar selected item state modifier
  void _onItemTapped(int index) {
    setState(() {
      _currentState = index;
    });
    onNavBarPressed(context);
  }

  void onNavBarPressed(BuildContext context) {
    if (_currentState == 1) {
      context.go('/applications');
    }
    if (_currentState == 0) {
      context.go('/home');
    }
    if (_currentState == 3) {
      context.go('/profile');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFF0309C8),
            elevation: 1,
            selectedIconTheme:
                IconThemeData(color: Color.fromARGB(255, 39, 76, 119)),
            selectedItemColor: Color.fromARGB(255, 39, 76, 119),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedIconTheme:
                IconThemeData(color: Color.fromARGB(255, 120, 163, 212)),
            unselectedItemColor: Color.fromARGB(255, 120, 163, 212),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.article), label: 'Applications'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.graphic_eq), label: 'Report'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: _currentState,
            onTap: _onItemTapped),
        body: GlobalBackground(
            child: Center(
          child: Container(
            padding: const EdgeInsets.only(
                top: 16.0, left: 24.0, right: 24.0, bottom: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title Text
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
        )));
  }
}
