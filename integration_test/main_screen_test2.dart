import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test2', () {
    testWidgets('verify pin code with incorrect pin',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      for (var i = 1; i <= 6; i++) {
        final numberButtonKey = find.byKey(const Key('numberButton1'));
        await tester.tap(numberButtonKey);
        await Future.delayed(const Duration(milliseconds: 500));
      }

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Pin is incorrect'), findsOneWidget);
    });
  });
}
