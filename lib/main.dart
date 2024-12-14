import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/views/auth/sign_in.dart';
import 'package:flutter_job_tracker_app/views/auth/sign_up.dart';
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
        routes: [
          GoRoute(
              path: '/sign_up.dart',
              builder: (context, state) {
                return SignUpPage();
              }),
          GoRoute(
            path: '/sign_in.dart',
            builder: (context, state) {
              return SignInPage();
            },
          ),
        ]),
  ],
);
