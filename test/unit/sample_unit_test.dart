import 'package:flutter_test/flutter_test.dart';

// A simple function to add two numbers
// 2つの数値を足す単純な関数
int add(int a, int b) => a + b;

void main() {
  test('Addition works correctly', () {
    // Test if the add function works as expected
    // add関数が期待通りに動作するかテストします
    expect(add(2, 3), 5);
    expect(add(-1, 1), 0);
  });
}
