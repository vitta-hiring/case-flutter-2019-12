
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';

import 'package:omdb_vitta/app/modules/home/home_page.dart';

void main() {
  testWidgets('HomePage has title', (tester) async {
     await tester.pumpWidget(buildTestableWidget(HomePage(title: 'Home')));
     final titleFinder = find.text('Home');
     expect(titleFinder, findsOneWidget);
  });
}
