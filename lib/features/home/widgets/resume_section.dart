import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/utils/launch_util.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../data/models/profile.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key, required this.sectionKey, required this.profile});

  final GlobalKey sectionKey;
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context);

    return SectionWrapper(
      sectionKey: sectionKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(eyebrow: 'Get the full picture', title: 'Resume'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.14),
                  theme.colorScheme.secondary.withValues(alpha: 0.10),
                ],
              ),
              border: Border.all(color: theme.dividerColor),
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.picture_as_pdf_outlined, size: 42, color: theme.colorScheme.primary),
                      const SizedBox(height: 16),
                      _ResumeBlurb(profile: profile),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        label: 'Download Resume',
                        icon: Icons.download_outlined,
                        onPressed: () => LaunchUtil.openUrl(profile.resumeAssetPath),
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.picture_as_pdf_outlined, size: 42, color: theme.colorScheme.primary),
                      const SizedBox(width: 24),
                      Expanded(child: _ResumeBlurb(profile: profile)),
                      const SizedBox(width: 24),
                      PrimaryButton(
                        label: 'Download Resume',
                        icon: Icons.download_outlined,
                        onPressed: () => LaunchUtil.openUrl(profile.resumeAssetPath),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _ResumeBlurb extends StatelessWidget {
  const _ResumeBlurb({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${profile.yearsFlutterExperience} years Flutter · ${profile.yearsAndroidExperience} years mobile development',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          'Download the full resume for a detailed breakdown of my experience, skills, and certifications.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}
