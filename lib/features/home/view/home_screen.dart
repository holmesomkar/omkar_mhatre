import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/breakpoints.dart';
import '../../../core/constants/section.dart';
import '../../../data/models/portfolio_data.dart';
import '../../../data/portfolio_repository.dart';
import '../bloc/nav_cubit.dart';
import '../widgets/achievements_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/expertise_section.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/projects_section.dart';
import '../widgets/resume_section.dart';
import '../widgets/side_nav_bar.dart';
import '../widgets/skills_section.dart';

/// The single scrolling page every section lives on. GoRouter always
/// resolves to this same widget (see [buildAppRouter]) — only
/// [activeSection] changes between navigations, which drives an animated
/// scroll to the matching section. Scrolling manually does the reverse:
/// it updates the active section and, after a short debounce, syncs the
/// URL to match — classic scrollspy behaviour.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.activeSection});

  final Section activeSection;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PortfolioRepository _repository = const PortfolioRepository();
  late final Future<PortfolioData> _dataFuture = _repository.load();
  final ScrollController _scrollController = ScrollController();
  final Map<Section, GlobalKey> _sectionKeys = {
    for (final section in Section.values)
      section: GlobalKey(debugLabel: section.name),
  };

  Timer? _urlSyncDebounce;
  bool _suppressScrollSpy = false;
  bool _didInitialScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeSection != widget.activeSection) {
      _scrollToSection(widget.activeSection);
    }
  }

  @override
  void dispose() {
    _urlSyncDebounce?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_suppressScrollSpy) return;
    final current = _computeActiveSection();
    if (current == null) return;
    final navCubit = context.read<NavCubit>();
    if (navCubit.state == current) return;
    navCubit.setActive(current);
    _urlSyncDebounce?.cancel();
    _urlSyncDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      final location = GoRouterState.of(context).uri.toString();
      if (location != current.path) {
        context.go(current.path);
      }
    });
  }

  Section? _computeActiveSection() {
    const band = 200.0;
    Section? best;
    double bestDistance = double.infinity;
    for (final entry in _sectionKeys.entries) {
      final renderObject = entry.value.currentContext?.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.attached) continue;
      final top = renderObject.localToGlobal(Offset.zero).dy;
      if (top <= band) {
        final distance = band - top;
        if (distance < bestDistance) {
          bestDistance = distance;
          best = entry.key;
        }
      }
    }
    return best ?? Section.about;
  }

  Future<void> _scrollToSection(Section section, {bool animate = true}) async {
    final target = _sectionKeys[section]?.currentContext;
    if (target == null) return;
    _suppressScrollSpy = true;
    await Scrollable.ensureVisible(
      target,
      duration: animate ? const Duration(milliseconds: 500) : Duration.zero,
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
    if (!mounted) return;
    context.read<NavCubit>().setActive(section);
    _suppressScrollSpy = false;
  }

  void _onNavTap(Section section) => context.go(section.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PortfolioData>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load content: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;

          if (!_didInitialScroll && widget.activeSection != Section.about) {
            _didInitialScroll = true;
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _scrollToSection(widget.activeSection, animate: false),
            );
          } else {
            _didInitialScroll = true;
          }

          final isDesktop = Breakpoints.isDesktop(context);

          final content = SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // On desktop the sidebar handles navigation, so content
                // starts at the top; on mobile/tablet a top bar overlays
                // the content, so this reserves space for it.
                if (!isDesktop) SizedBox(height: NavBar.height),
                HeroSection(
                  sectionKey: _sectionKeys[Section.about]!,
                  profile: data.profile,
                  onViewResume: () => _onNavTap(Section.resume),
                  onContact: () => _onNavTap(Section.contact),
                ),
                SkillsSection(
                  sectionKey: _sectionKeys[Section.skills]!,
                  skillGroups: data.skillGroups,
                ),
                ExperienceSection(
                  sectionKey: _sectionKeys[Section.experience]!,
                  experience: data.experience,
                ),
                ProjectsSection(
                  sectionKey: _sectionKeys[Section.projects]!,
                  projects: data.projects,
                ),
                ExpertiseSection(
                  sectionKey: _sectionKeys[Section.expertise]!,
                  highlights: data.expertiseHighlights,
                ),
                AchievementsSection(
                  sectionKey: _sectionKeys[Section.achievements]!,
                  achievements: data.achievements,
                  education: data.education,
                ),
                ResumeSection(
                  sectionKey: _sectionKeys[Section.resume]!,
                  profile: data.profile,
                ),
                ContactSection(
                  sectionKey: _sectionKeys[Section.contact]!,
                  profile: data.profile,
                ),
                Footer(profile: data.profile),
              ],
            ),
          );

          if (isDesktop) {
            // A permanent left navigation rail beside the scrolling
            // content — the desktop-website layout, distinct from the
            // top-bar-over-content pattern mobile/tablet use.
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SideNavBar(profile: data.profile, onSectionTap: _onNavTap),
                Expanded(child: content),
              ],
            );
          }

          return Stack(
            children: [
              content,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: NavBar(name: data.profile.name, onSectionTap: _onNavTap),
              ),
            ],
          );
        },
      ),
    );
  }
}
