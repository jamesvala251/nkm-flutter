import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseFcmTokenService {
  static Future<String> getFcmToken() async {
    try {
      if (Platform.isAndroid) {
        return await FirebaseMessaging.instance.getToken() ?? '';
      } else {
        return await FirebaseMessaging.instance.getAPNSToken() ?? '';
      }
    } catch (err) {
      return '';
    }
  }
}
