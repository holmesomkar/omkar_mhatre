class Education {
  const Education({
    required this.institution,
    required this.degree,
    required this.period,
    required this.location,
    required this.detail,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      period: json['period'] as String,
      location: json['location'] as String,
      detail: json['detail'] as String,
    );
  }

  final String institution;
  final String degree;
  final String period;
  final String location;
  final String detail;
}
