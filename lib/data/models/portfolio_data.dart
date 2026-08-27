import 'achievement_item.dart';
import 'education.dart';
import 'experience_item.dart';
import 'expertise_highlight.dart';
import 'profile.dart';
import 'project_item.dart';
import 'skill_group.dart';

class PortfolioData {
  const PortfolioData({
    required this.profile,
    required this.skillGroups,
    required this.expertiseHighlights,
    required this.experience,
    required this.projects,
    required this.achievements,
    required this.education,
  });

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      skillGroups: (json['skillGroups'] as List<dynamic>)
          .map((e) => SkillGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      expertiseHighlights: (json['expertiseHighlights'] as List<dynamic>)
          .map((e) => ExpertiseHighlight.fromJson(e as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>)
          .map((e) => ExperienceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      projects: (json['projects'] as List<dynamic>)
          .map((e) => ProjectItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => AchievementItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      education: Education.fromJson(json['education'] as Map<String, dynamic>),
    );
  }

  final Profile profile;
  final List<SkillGroup> skillGroups;
  final List<ExpertiseHighlight> expertiseHighlights;
  final List<ExperienceItem> experience;
  final List<ProjectItem> projects;
  final List<AchievementItem> achievements;
  final Education education;
}
