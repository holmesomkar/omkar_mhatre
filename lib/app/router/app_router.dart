import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/section.dart';
import '../../features/home/view/home_screen.dart';

/// One GoRoute per section path, but every route resolves to the same
/// [HomeScreen] page (fixed page key) so its scroll position and animation
/// state survive navigation between sections — only the target section to
/// scroll to changes. This is what makes deep links like `/experience` and
/// browser back/forward work on what is otherwise a single scrolling page.
GoRouter buildAppRouter() {
  return GoRouter(
    initialLocation: Section.about.path,
    routes: [
      for (final section in Section.values)
        GoRoute(
          path: section.path,
          pageBuilder: (context, state) => NoTransitionPage(
            key: const ValueKey('home'),
            child: HomeScreen(activeSection: section),
          ),
        ),
    ],
  );
}
