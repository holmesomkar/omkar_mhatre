class ExpertiseHighlight {
  const ExpertiseHighlight({
    required this.title,
    required this.description,
    required this.icon,
  });

  factory ExpertiseHighlight.fromJson(Map<String, dynamic> json) {
    return ExpertiseHighlight(
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  final String title;
  final String description;
  final String icon;
}
