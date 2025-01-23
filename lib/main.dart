import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_job_tracker_app/view/core/application/applications_list_view.dart';
import 'package:flutter_job_tracker_app/view/core/proflie_view.dart';
import 'package:flutter_job_tracker_app/view/core/report_view.dart';
import 'package:flutter_job_tracker_app/viewmodel/signin_viewmodel.dart';
import 'package:flutter_job_tracker_app/viewmodel/signup_viewmodel.dart';
import 'package:flutter_job_tracker_app/viewmodel/profile_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'view/launch/start_view.dart';
import 'view/launch/tracking_view.dart';
import 'view/launch/comparison_view.dart';
import 'view/auth/signup_view.dart';
import 'view/auth/signin_view.dart';
import 'view/core/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        // Add other providers here as needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Job Tracker',
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
    GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const StartPage(), state);
      },
    ),
    GoRoute(
      path: '/tracking',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const TrackingPage(), state);
      },
    ),
    GoRoute(
      path: '/comparison',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const ComparisonPage(), state);
      },
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const SignUpPage(), state);
      },
    ),
    GoRoute(
      path: '/signin',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const SignInPage(), state);
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const HomePage(), state);
      },
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const ProfilePage(), state);
      },
    ),
    GoRoute(
      path: '/report',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const ReportPage(), state);
      },
    ),
    GoRoute(
      path: '/applications',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return _customFadeTransition(const ApplicationsPage(), state);
      },
    ),
  ],
);

CustomTransitionPage<void> _customFadeTransition(
    Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
