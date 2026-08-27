class AchievementItem {
  const AchievementItem({
    required this.title,
    required this.description,
    required this.category,
  });

  factory AchievementItem.fromJson(Map<String, dynamic> json) {
    return AchievementItem(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
    );
  }

  final String title;
  final String description;
  final String category;
}
