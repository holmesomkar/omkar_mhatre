import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:omkar_mhatre/app/app.dart';

/// Regression guard for layout-overflow bugs (fixed-height GridView rows,
/// Row/Flex content wider than its container) across the widths that
/// actually matter: common phones, the mobile/tablet/desktop breakpoints
/// themselves, and common desktop sizes.
void main() {
  const widths = [
    320.0, 360.0, 375.0, 390.0, 414.0, 428.0, // phones
    600.0, 601.0, // mobile/tablet breakpoint
    768.0, 834.0, // tablets
    1023.0, 1024.0, // tablet/desktop breakpoint
    1280.0, 1440.0, 1920.0, // desktop
  ];

  for (final width in widths) {
    testWidgets('renders without layout errors at width $width', (tester) async {
      addTearDown(tester.view.resetPhysicalSize);
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(PortfolioApp());
      await tester.pump();
      for (var i = 0; i < 15; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }

      expect(tester.takeException(), isNull, reason: 'Layout exception at width $width');
    });
  }
}
