import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  // Bottom navigation list index and elements (to be changed)
  List<Widget> body = const [
    Icon(Icons.home),
    Icon(Icons.article),
    Icon(Icons.graphic_eq),
    Icon(Icons.person),
  ];

  // NavBar selected item state
  int _currentState = 0;

  // NavBar selected item state modifier
  void _onItemTapped(int index) {
    setState(() {
      _currentState = index;
    });
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentState,
        onTap: _onItemTapped,
      ),
      body: Container(
        // Background Colour
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF57C7DB), Color(0xFF0309C8)],
          ),
        ),
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
                    'Recent Applications',
                    style: _textStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 100),
                  // Application Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        //context.go('/application/1/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        'Application 1',
                        style: _textStyle(
                          color: Color(0xFF0309C8),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        //context.go('/application/1/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        'Application 2',
                        style: _textStyle(
                          color: Color(0xFF0309C8),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        //context.go('/application/1/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Text(
                        'Application 3',
                        style: _textStyle(
                          color: Color(0xFF0309C8),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
