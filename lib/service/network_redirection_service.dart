import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncher {
  static Future<void> launchPageURL(String urlString) async {
    final url =
        Uri.tryParse(urlString) ?? Uri.https('https://wikipedia.org', '/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
