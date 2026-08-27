import 'package:flutter/material.dart';

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
    return Container(
      key: sectionKey,
      width: double.infinity,
      color: tinted ? theme.colorScheme.surface : Colors.transparent,
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
