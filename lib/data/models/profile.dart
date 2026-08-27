class Profile {
  const Profile({
    required this.name,
    required this.title,
    required this.tagline,
    required this.location,
    required this.email,
    required this.phone,
    required this.github,
    required this.linkedin,
    required this.bio,
    required this.yearsFlutterExperience,
    required this.yearsAndroidExperience,
    required this.resumeAssetPath,
    required this.resumeFileName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      github: json['github'] as String,
      linkedin: json['linkedin'] as String,
      bio: json['bio'] as String,
      yearsFlutterExperience: json['yearsFlutterExperience'] as String,
      yearsAndroidExperience: json['yearsAndroidExperience'] as String,
      resumeAssetPath: json['resumeAssetPath'] as String,
      resumeFileName: json['resumeFileName'] as String,
    );
  }

  final String name;
  final String title;
  final String tagline;
  final String location;
  final String email;
  final String phone;
  final String github;
  final String linkedin;
  final String bio;
  final String yearsFlutterExperience;
  final String yearsAndroidExperience;
  final String resumeAssetPath;
  final String resumeFileName;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}
