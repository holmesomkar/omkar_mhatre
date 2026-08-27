import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../constants/breakpoints.dart';

/// Common chrome every section shares: centered max-width content, a
/// consistent responsive vertical rhythm, and an optional alternate
/// background tint so sections visually separate without hard borders.
class SectionWrapper extends StatelessWidget {
  const SectionWrapper({
    super.key,
    required this.sectionKey,
    required this.child,
    this.tinted = false,
  });

  final GlobalKey sectionKey;
  final Widget child;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      key: sectionKey,
      width: double.infinity,
      // A distinct tone from card surfaces, so cards don't blend into a
      // tinted section's background.
      color: tinted ? (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt) : Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 56 : 88,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
