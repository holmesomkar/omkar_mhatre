import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../core/widgets/skill_chip.dart';
import '../../../data/models/skill_group.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key, required this.sectionKey, required this.skillGroups});

  final GlobalKey sectionKey;
  final List<SkillGroup> skillGroups;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SectionWrapper(
      sectionKey: sectionKey,
      tinted: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'What I work with', title: 'Skills'),
          for (var i = 0; i < skillGroups.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skillGroups[i].title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final skill in skillGroups[i].skills) SkillChip(label: skill),
                    ],
                  ),
                ],
              ),
            ).animate(delay: (i * 80).ms).fadeIn(duration: 400.ms).slideX(begin: 0.05, end: 0),
        ],
      ),
    );
  }
}
