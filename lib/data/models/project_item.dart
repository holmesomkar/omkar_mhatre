class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.company,
    required this.description,
    required this.tags,
  });

  factory ProjectItem.fromJson(Map<String, dynamic> json) {
    return ProjectItem(
      title: json['title'] as String,
      company: json['company'] as String,
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).cast<String>(),
    );
  }

  final String title;
  final String company;
  final String description;
  final List<String> tags;
}
