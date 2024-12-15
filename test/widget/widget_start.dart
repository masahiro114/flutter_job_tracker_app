import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/view/launch/start_view.dart';

void main() {
  testWidgets('StartPage has title, subtitle, and button, and navigation works', (WidgetTester tester) async {
    // Build the widget tree with GoRouter
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: _router,
      ),
    );

    // Verify that the title and subtitle are rendered
    expect(find.text('Job Tracker'), findsOneWidget);
    expect(find.text('Your path to career success, tracked and managed.'), findsOneWidget);

    // Verify the "Continue to sign up" button is present
    expect(find.text('Continue to sign up'), findsOneWidget);

    // Verify that the "Sign in" link is present
    expect(find.text('Sign in'), findsOneWidget);

    // Tap the "Continue to sign up" button
    await tester.tap(find.text('Continue to sign up'));
    await tester.pumpAndSettle(); // Wait for navigation to settle

    // Check if navigation to /tracking happens
    expect(find.byType(TrackingPage), findsOneWidget);  // Assuming you have a TrackingPage widget
  });
}

// Define the GoRouter for testing
final GoRouter _router = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      },
    ),
    GoRoute(
      path: '/tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const TrackingPage(); // Define this page for the test
      },
    ),
  ],
);

// Dummy TrackingPage for testing
class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tracking')),
      body: const Center(child: Text('Tracking Page Content')),
    );
  }
}
