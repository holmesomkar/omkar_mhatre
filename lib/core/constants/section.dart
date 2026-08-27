/// The nine portfolio sections, in display order. Also drives GoRouter's
/// paths (`/`, `/skills`, ...) and the nav bar / scroll-spy highlighting.
enum Section {
  about('/', 'About'),
  skills('/skills', 'Skills'),
  experience('/experience', 'Experience'),
  projects('/projects', 'Projects'),
  expertise('/expertise', 'Expertise'),
  achievements('/achievements', 'Achievements'),
  resume('/resume', 'Resume'),
  contact('/contact', 'Contact');

  const Section(this.path, this.label);

  final String path;
  final String label;
}
