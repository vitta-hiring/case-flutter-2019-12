// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:movietta/app/widgets/white_text_widget.dart';

void main() {
  testWidgets('Test WhiteText widget', (WidgetTester tester) async {
    await tester.pumpWidget(WhiteText(
      text: 'Arara',
      fontSize: 20,
    ));
    final textFinder = find.text('Arara');
    expect(textFinder, findsOneWidget);

    // Tap the '+' icon and trigger a frame.
  });
}