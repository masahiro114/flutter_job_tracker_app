import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/launch/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    // Define the route for StartPage
    GoRoute(
      path: '/', 
      builder: (context, state) {
        return const StartPage();
      },
    ),

  ],
);