class ExperienceItem {
  const ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.bullets,
  });

  factory ExperienceItem.fromJson(Map<String, dynamic> json) {
    return ExperienceItem(
      company: json['company'] as String,
      role: json['role'] as String,
      period: json['period'] as String,
      location: json['location'] as String,
      bullets: (json['bullets'] as List<dynamic>).cast<String>(),
    );
  }

  final String company;
  final String role;
  final String period;
  final String location;
  final List<String> bullets;
}
