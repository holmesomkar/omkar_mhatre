import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../data/models/achievement_item.dart';
import '../../../data/models/education.dart';

IconData _categoryIcon(String category) {
  switch (category) {
    case 'Academic':
      return Icons.school_outlined;
    case 'Certification':
      return Icons.workspace_premium_outlined;
    case 'Professional':
      return Icons.emoji_events_outlined;
    default:
      return Icons.star_outline;
  }
}

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({
    super.key,
    required this.sectionKey,
    required this.achievements,
    required this.education,
  });

  final GlobalKey sectionKey;
  final List<AchievementItem> achievements;
  final Education education;

  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final columns = Breakpoints.isMobile(context) ? 1 : 2;
    return SectionWrapper(
      sectionKey: sectionKey,
      tinted: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Recognition & growth', title: 'Achievements'),
          // A Wrap of content-sized cards instead of a fixed-height
          // GridView row, so a longer description never overflows.
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - _spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: [
                  for (var index = 0; index < achievements.length; index++)
                    SizedBox(
                      width: cardWidth,
                      child: HoverLift(
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(_categoryIcon(achievements[index].category), color: theme.colorScheme.primary),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      achievements[index].title,
                                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      achievements[index].description,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animate(delay: (index * 60).ms).fadeIn(duration: 350.ms),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                Icon(Icons.school, color: theme.colorScheme.primary),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(education.degree, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                      Text(
                        '${education.institution} · ${education.period}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                      Text(
                        education.detail,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
