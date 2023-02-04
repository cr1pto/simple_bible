// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_bible/screens/stateless/home_screen.dart';

import 'test_helpers.dart';

Future main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  GetIt di = await TestHelpers().createContainer();

  testWidgets('Application Loads Successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(HomeScreen());

    await tester.tap(find.byType(HomeScreen));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('Home'), findsOneWidget);
  });
}
