class SkillGroup {
  const SkillGroup({required this.title, required this.skills});

  factory SkillGroup.fromJson(Map<String, dynamic> json) {
    return SkillGroup(
      title: json['title'] as String,
      skills: (json['skills'] as List<dynamic>).cast<String>(),
    );
  }

  final String title;
  final List<String> skills;
}
