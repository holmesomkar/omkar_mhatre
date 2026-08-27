import 'package:flutter_test/flutter_test.dart';

import 'package:omkar_mhatre/app/app.dart';

void main() {
  testWidgets('portfolio loads content and renders the hero section', (tester) async {
    await tester.pumpWidget(PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.textContaining("Hi, I'm"), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Contact'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
