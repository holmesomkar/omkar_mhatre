import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/constants/section.dart';
import '../bloc/nav_cubit.dart';
import '../bloc/theme_cubit.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.name,
    required this.onSectionTap,
  });

  final String name;
  final ValueChanged<Section> onSectionTap;

  static const double height = 72;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = Breakpoints.isDesktop(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withValues(alpha: 0.72),
            border: Border(bottom: BorderSide(color: theme.dividerColor)),
          ),
          child: Row(
            children: [
              Text(
                name,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              if (isDesktop)
                BlocBuilder<NavCubit, Section>(
                  builder: (context, active) {
                    return Row(
                      children: [
                        for (final section in Section.values)
                          _NavLink(
                            label: section.label,
                            isActive: section == active,
                            onTap: () => onSectionTap(section),
                          ),
                      ],
                    );
                  },
                )
              else
                _MobileMenuButton(onSectionTap: onSectionTap),
              const SizedBox(width: 12),
              _ThemeToggle(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.isActive, required this.onTap});

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
        ),
        child: Text(
          label,
          style: TextStyle(fontWeight: isActive ? FontWeight.w700 : FontWeight.w500),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.onSectionTap});

  final ValueChanged<Section> onSectionTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      tooltip: 'Menu',
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (sheetContext) {
            return SafeArea(
              child: BlocBuilder<NavCubit, Section>(
                builder: (context, active) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final section in Section.values)
                        ListTile(
                          title: Text(section.label),
                          selected: section == active,
                          onTap: () {
                            Navigator.of(sheetContext).pop();
                            onSectionTap(section);
                          },
                        ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return IconButton(
          tooltip: mode == ThemeMode.dark ? 'Switch to light mode' : 'Switch to dark mode',
          icon: Icon(mode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          onPressed: () => context.read<ThemeCubit>().toggle(),
        );
      },
    );
  }
}
