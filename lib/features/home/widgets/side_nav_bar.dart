import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/section.dart';
import '../../../core/utils/launch_util.dart';
import '../../../data/models/profile.dart';
import '../bloc/nav_cubit.dart';
import '../bloc/theme_cubit.dart';

/// The desktop-only chrome: a fixed left column with identity, section
/// nav, and social links, so the page reads as a website with a
/// permanent navigation rail rather than a mobile screen with a
/// scrolling top bar stretched to fit a wide viewport.
class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key, required this.profile, required this.onSectionTap});

  final Profile profile;
  final ValueChanged<Section> onSectionTap;

  static const double width = 296;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Identity(profile: profile),
              const SizedBox(height: 48),
              BlocBuilder<NavCubit, Section>(
                builder: (context, active) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final section in Section.values)
                      _SideNavLink(
                        label: section.label,
                        isActive: section == active,
                        onTap: () => onSectionTap(section),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  _SocialIconButton(icon: FontAwesomeIcons.github, onTap: () => LaunchUtil.openUrl(profile.github)),
                  _SocialIconButton(icon: FontAwesomeIcons.linkedinIn, onTap: () => LaunchUtil.openUrl(profile.linkedin)),
                  _SocialIconButton(icon: FontAwesomeIcons.envelope, onTap: () => LaunchUtil.sendEmail(profile.email)),
                ],
              ),
              const SizedBox(height: 24),
              const _ThemeToggleRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Identity extends StatelessWidget {
  const _Identity({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        _MiniAvatar(profile: profile),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                profile.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final photoAssetPath = profile.photoAssetPath;
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
      ),
      alignment: Alignment.center,
      padding: photoAssetPath == null ? EdgeInsets.zero : const EdgeInsets.all(2),
      child: photoAssetPath == null
          ? Text(
              profile.initials,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
            )
          : ClipOval(
              child: Image.asset(
                photoAssetPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Text(
                  profile.initials,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
            ),
    );
  }
}

class _SideNavLink extends StatefulWidget {
  const _SideNavLink({required this.label, required this.isActive, required this.onTap});

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_SideNavLink> createState() => _SideNavLinkState();
}

class _SideNavLinkState extends State<_SideNavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final highlighted = widget.isActive || _hovering;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: highlighted ? theme.colorScheme.primary.withValues(alpha: widget.isActive ? 0.14 : 0.07) : null,
            border: Border(
              left: BorderSide(
                color: widget.isActive ? theme.colorScheme.primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
              color: highlighted ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({required this.icon, required this.onTap});

  final FaIconData icon;
  final VoidCallback onTap;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovering ? theme.colorScheme.primary.withValues(alpha: 0.12) : null,
            border: Border.all(color: _hovering ? theme.colorScheme.primary : theme.dividerColor),
          ),
          child: FaIcon(
            widget.icon,
            size: 16,
            color: _hovering ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleRow extends StatelessWidget {
  const _ThemeToggleRow();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final isDark = mode == ThemeMode.dark;
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => context.read<ThemeCubit>().toggle(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, size: 18),
                const SizedBox(width: 10),
                Text(
                  isDark ? 'Light mode' : 'Dark mode',
                  style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
