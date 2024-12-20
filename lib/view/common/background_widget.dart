import 'package:flutter/material.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;

  const GlobalBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
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
                  image: AssetImage('assets/images/background_icon.png'), // Correct asset path
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Child content, where the actual page will be placed
          child,
        ],
      ),
    );
  }
}
