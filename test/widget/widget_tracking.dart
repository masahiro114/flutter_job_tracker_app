import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_job_tracker_app/main.dart';
import 'package:flutter_job_tracker_app/views/launch/tracking.dart';

void main() {
  testWidgets('TrackingPage has title, subtitle, and button, and navigation works', (WidgetTester tester) async {
    // Build the widget tree with GoRouter
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: _router,
      ),
    );

    // Verify that the title and subtitle are rendered
    expect(find.text('Tracking'), findsOneWidget);
    expect(find.text('You can track job applications and check your status.'), findsOneWidget);

    // Verify the "Continue to sign up" button is present
    expect(find.text('Continue'), findsOneWidget);

    // Verify that the "Sign in" link is present
    expect(find.text('Sign in'), findsOneWidget);

    // Tap the "Continue to sign up" button
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle(); // Wait for navigation to settle

    // Check if navigation to /tracking happens
    expect(find.byType(TrackingPage), findsOneWidget);  // Assuming you have a TrackingPage widget
  });
}

// Define the GoRouter for testing
final GoRouter _router = GoRouter(
  initialLocation: '/tracking', 
  routes: [
    GoRoute(
      path: '/tracking',
      builder: (BuildContext context, GoRouterState state) {
        return const TrackingPage();
      },
    ),
    GoRoute(
      path: '/comparison',
      builder: (BuildContext context, GoRouterState state) {
        return const ComparisonPage(); // Define this page for the test
      },
    ),
  ],
);

// Dummy ComparisonPage for testing
class ComparisonPage extends StatelessWidget {
  const ComparisonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comparison')),
      body: Center(child: Text('Comparison Page Content')),
    );
  }
}
