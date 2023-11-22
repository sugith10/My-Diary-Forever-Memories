import 'package:url_launcher/url_launcher.dart';

class ProfileScreenFunctions {
  // Private function for launching email
  Future<void> _launchEmail() async {
    const String emailAddress = 'dayproductionltd@gmail.com';
    const String emailSubject = 'Help_me';
    const String emailBody = 'Need_help';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': emailSubject,
        'body': emailBody,
      },
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      print('Error launching email: $e');
    }
  }

   Future<void> _launchPrivacyPolicy() async {

    final Uri _url = Uri.parse('https://www.freeprivacypolicy.com/live/7a362b50-908e-4f46-ba36-617bab644ff9');

    try {
      await launchUrl(_url);
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  String _getGreeting() {
    var now = DateTime.now();
    if (now.isAfter(DateTime(now.year, now.month, now.day, 0, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 12, 0))) {
      return '🤓 Good morning';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 12, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 18, 0))) {
      return '😏 Good afternoon';
    } else if (now.isAfter(DateTime(now.year, now.month, now.day, 18, 0)) &&
        now.isBefore(DateTime(now.year, now.month, now.day, 20, 0))) {
      return '😊 Good evening';
    } else {
      return '😍 How was your day?';
    }
  }



  // Public function to be used from other classes
  Future<void> launchEmail() async {
    await _launchEmail();
  }

  Future<void> launchPrivacyPolicy() async {
    await _launchPrivacyPolicy();
  }

  String getGreeting(){
    return _getGreeting();
  }
}
