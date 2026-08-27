import 'package:flutter/widgets.dart';

/// Shared responsive breakpoints for the portfolio.
class Breakpoints {
  const Breakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobile && width < tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tablet;

  /// Max content width so text/cards don't stretch edge-to-edge on large screens.
  static const double maxContentWidth = 1120;
}
