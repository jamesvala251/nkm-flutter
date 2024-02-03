
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFcmTokenService {
  static Future<String> getFcmToken() async {
    try {
        return await FirebaseMessaging.instance.getToken() ?? '';
    } catch (err) {
      return '';
    }
  }
}
