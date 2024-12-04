import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// A simple widget to display a text
// テキストを表示する簡単なウィジェット
class MyWidget extends StatelessWidget {
  final String title;

  MyWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
      ),
    );
  }
}

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    // Build the widget
    // ウィジェットを構築します
    await tester.pumpWidget(MyWidget(title: 'Hello'));

    // Verify the widget displays the correct title
    // 正しいタイトルが表示されることを確認します
    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Goodbye'), findsNothing);
  });
}
