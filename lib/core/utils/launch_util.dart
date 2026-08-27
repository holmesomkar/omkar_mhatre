import 'package:url_launcher/url_launcher.dart';

/// Thin wrapper around url_launcher for the handful of outbound links the
/// portfolio needs (email, phone, external profiles, resume download).
class LaunchUtil {
  const LaunchUtil._();

  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> sendEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    await launchUrl(uri);
  }

  static Future<void> callPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    await launchUrl(uri);
  }
}
