import 'package:flutter/material.dart';

/// Wraps a card with a subtle lift-and-shadow reaction to the mouse —
/// the kind of hover feedback a desktop website has and a touch-only
/// mobile app doesn't. No-ops gracefully on touch (no hover event fires).
class HoverLift extends StatefulWidget {
  const HoverLift({super.key, required this.child});

  final Widget child;

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovering ? -6 : 0, 0),
        decoration: BoxDecoration(
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.22),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ]
              : const [],
        ),
        child: widget.child,
      ),
    );
  }
}
