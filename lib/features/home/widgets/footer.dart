import 'package:flutter/material.dart';

import '../../../data/models/profile.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: theme.dividerColor))),
      child: Center(
        child: Text(
          '© ${DateTime.now().year} ${profile.name}. Built with Flutter.',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}
