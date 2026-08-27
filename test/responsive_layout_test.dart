import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:omkar_mhatre/app/app.dart';

/// Regression test for overflow bugs in the card grids (Projects,
/// Expertise, Achievements, Contact): these previously used a fixed
/// GridView row height that could overflow at narrow widths once real
/// content (long titles, multiple tags) didn't fit the guessed height.
void main() {
  testWidgets('portfolio renders without layout errors at a mobile width', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.textContaining("Hi, I'm"), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
