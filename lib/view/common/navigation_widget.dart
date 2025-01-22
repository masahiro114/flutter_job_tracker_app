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
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Applications'),
        BottomNavigationBarItem(icon: Icon(Icons.graphic_eq), label: 'Report'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        onItemTapped(index); // Call the callback when an item is tapped
      },
    );
  }
}
