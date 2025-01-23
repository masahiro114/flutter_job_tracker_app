import 'package:flutter/material.dart';

class GlobalNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const GlobalNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Common navigation theme
      type: BottomNavigationBarType.fixed,
      elevation: 1,
      backgroundColor: const Color(0xFF0309C8),
      // Selected menu item theme
      selectedIconTheme: const IconThemeData(color: Colors.white),
      selectedItemColor: const Color(0xFFFFFFFF),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      // Unselected menu item theme
      unselectedIconTheme: const IconThemeData(color: Colors.white70),
      unselectedItemColor: const Color(0xB3FFFFFF),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Applications'),
        BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Report'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: currentIndex,
      onTap: onItemTapped, // Directly call the passed callback
    );
  }

}
