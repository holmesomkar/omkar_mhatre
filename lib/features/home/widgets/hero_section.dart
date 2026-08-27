import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/utils/launch_util.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_wrapper.dart';
import '../../../data/models/profile.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.sectionKey,
    required this.profile,
    required this.onViewResume,
    required this.onContact,
  });

  final GlobalKey sectionKey;
  final Profile profile;
  final VoidCallback onViewResume;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Breakpoints.isMobile(context);
    final isDesktop = Breakpoints.isDesktop(context);

    final avatar = _Avatar(initials: profile.initials, photoAssetPath: profile.photoAssetPath);

    final textColumn = Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'SENIOR FLUTTER DEVELOPER',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Hi, I'm ${profile.name}",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: isDesktop ? 64 : null,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          profile.tagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.75)),
        ),
        const SizedBox(height: 24),
        Text(
          profile.bio,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 32),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            PrimaryButton(label: 'View Resume', icon: Icons.description_outlined, onPressed: onViewResume),
            PrimaryButton(label: 'Contact Me', icon: Icons.mail_outline, outlined: true, onPressed: onContact),
          ],
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 20,
          children: [
            _SocialIcon(icon: FontAwesomeIcons.github, onTap: () => LaunchUtil.openUrl(profile.github)),
            _SocialIcon(icon: FontAwesomeIcons.linkedinIn, onTap: () => LaunchUtil.openUrl(profile.linkedin)),
            _SocialIcon(icon: FontAwesomeIcons.envelope, onTap: () => LaunchUtil.sendEmail(profile.email)),
            _SocialIcon(icon: FontAwesomeIcons.phone, onTap: () => LaunchUtil.callPhone(profile.phone)),
          ],
        ),
      ],
    );

    return SectionWrapper(
      sectionKey: sectionKey,
      child: isMobile
          ? Column(
              children: [
                avatar,
                const SizedBox(height: 32),
                textColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: textColumn),
                const SizedBox(width: 48),
                Expanded(flex: 2, child: Center(child: avatar)),
              ],
            ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials, required this.photoAssetPath});

  final String initials;
  final String? photoAssetPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.35),
            blurRadius: 48,
            spreadRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.center,
      // A little breathing room between the photo and the gradient ring,
      // so the fade below has somewhere to dissolve into.
      padding: photoAssetPath == null ? EdgeInsets.zero : const EdgeInsets.all(5),
      child: photoAssetPath == null
          ? Text(
              initials,
              style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w800, color: Colors.white),
            )
          : ClipOval(
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (bounds) => const RadialGradient(
                  colors: [Colors.white, Colors.white, Colors.transparent],
                  stops: [0.0, 0.85, 1.0],
                ).createShader(bounds),
                child: Image.asset(
                  photoAssetPath!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Text(
                      initials,
                      style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
    ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack);
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon, required this.onTap});

  final FaIconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: theme.dividerColor),
        ),
        child: FaIcon(icon, size: 18),
      ),
    );
  }
}
