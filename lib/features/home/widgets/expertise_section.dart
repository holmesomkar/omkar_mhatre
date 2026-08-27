import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../data/models/expertise_highlight.dart';

IconData _iconFor(String key) {
  switch (key) {
    case 'flutter':
      return Icons.flutter_dash;
    case 'android':
      return Icons.android;
    case 'react':
      return Icons.widgets_outlined;
    case 'api':
      return Icons.api;
    case 'bloc':
      return Icons.account_tree_outlined;
    case 'router':
      return Icons.alt_route;
    case 'firebase':
      return Icons.local_fire_department_outlined;
    case 'git':
      return Icons.merge_type;
    case 'azure':
      return Icons.cloud_outlined;
    default:
      return Icons.code;
  }
}

class ExpertiseSection extends StatelessWidget {
  const ExpertiseSection({super.key, required this.sectionKey, required this.highlights});

  final GlobalKey sectionKey;
  final List<ExpertiseHighlight> highlights;

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final columns = Breakpoints.isMobile(context) ? 1 : (Breakpoints.isTablet(context) ? 2 : 3);
    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Deep dive', title: 'Technical Expertise'),
          // A Wrap of content-sized cards instead of a fixed-height
          // GridView row, so a longer description never overflows.
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - _spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: [
                  for (var i = 0; i < highlights.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: HoverLift(child: _ExpertiseCard(item: highlights[i]))
                          .animate(delay: (i * 70).ms)
                          .fadeIn(duration: 400.ms)
                          .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1)),
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

class _ExpertiseCard extends StatelessWidget {
  const _ExpertiseCard({required this.item});

  final ExpertiseHighlight item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_iconFor(item.icon), color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 14),
          Text(item.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(
            item.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
