import 'package:flutter_test/flutter_test.dart';

int addTwoNumber(int a, int b) {
  return a + b;
}

void main() {
  test('test for Add two number', () {
    final actual = addTwoNumber(10, 20);
    final expected = 30; //failed for 40
    expect(actual, expected);
  });


  test("test for data type", () {
    final result = addTwoNumber(10, 20);
    final actual = result.runtimeType;
    final expected = int; //failed for string
    expect(actual, expected);
  });
}