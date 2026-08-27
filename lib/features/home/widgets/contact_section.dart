import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/utils/launch_util.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../data/models/profile.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.sectionKey, required this.profile});

  final GlobalKey sectionKey;
  final Profile profile;

  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    final columns = Breakpoints.isMobile(context) ? 1 : 2;
    final tiles = [
      _ContactTile(
        icon: FontAwesomeIcons.envelope,
        label: 'Email',
        value: profile.email,
        onTap: () => LaunchUtil.sendEmail(profile.email),
      ),
      _ContactTile(
        icon: FontAwesomeIcons.phone,
        label: 'Phone',
        value: profile.phone,
        onTap: () => LaunchUtil.callPhone(profile.phone),
      ),
      _ContactTile(
        icon: FontAwesomeIcons.github,
        label: 'GitHub',
        value: profile.github.replaceFirst('https://', ''),
        onTap: () => LaunchUtil.openUrl(profile.github),
      ),
      _ContactTile(
        icon: FontAwesomeIcons.linkedinIn,
        label: 'LinkedIn',
        value: profile.linkedin.replaceFirst('https://', ''),
        onTap: () => LaunchUtil.openUrl(profile.linkedin),
      ),
    ];

    return SectionWrapper(
      sectionKey: sectionKey,
      tinted: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: "Let's talk", title: 'Contact'),
          Text(
            "I'm open to Senior Flutter Developer roles and collaborations — reach out through any of the channels below.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - _spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: [
                  for (var index = 0; index < tiles.length; index++)
                    SizedBox(
                      width: tileWidth,
                      child: tiles[index].animate(delay: (index * 70).ms).fadeIn(duration: 350.ms),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final FaIconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(icon, size: 16, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(label, style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    )),
                    Text(
                      value,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
