import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/widgets/hover_lift.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../core/widgets/skill_chip.dart';
import '../../../data/models/project_item.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.sectionKey, required this.projects});

  final GlobalKey sectionKey;
  final List<ProjectItem> projects;

  static const double _spacing = 20;

  @override
  Widget build(BuildContext context) {
    final columns = Breakpoints.isDesktop(context) ? 2 : 1;
    return SectionWrapper(
      sectionKey: sectionKey,
      tinted: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Selected work', title: 'Projects'),
          // A Wrap of fixed-width, content-sized cards — rather than a
          // GridView with a guessed fixed row height — so a longer title
          // or an extra tag never overflows the card.
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - _spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: _spacing,
                runSpacing: _spacing,
                children: [
                  for (var i = 0; i < projects.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: HoverLift(child: _ProjectCard(project: projects[i]))
                          .animate(delay: (i * 90).ms)
                          .fadeIn(duration: 400.ms)
                          .slideY(begin: 0.08, end: 0),
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

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(project.title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(
              project.company,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final tag in project.tags) SkillChip(label: tag)],
            ),
          ],
        ),
      ),
    );
  }
}
