import 'package:flutter_test/flutter_test.dart';
import 'package:kora/main.dart';

void main() {
  testWidgets('KoraApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const KoraApp());
    await tester.pump();
    expect(find.byType(KoraApp), findsOneWidget);
  });
}
