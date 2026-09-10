import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Service responsible for managing Firebase Cloud Messaging (FCM) tokens & permissions.
class FcmService {
  static bool _initialized = false;

  static Future<void> initializeFirebase() async {
    if (!_initialized) {
      try {
        // await Firebase.initializeApp(
        //   options: const FirebaseOptions(
        //     apiKey: 'AIzaSyCI3qbqvX0iVnDCQt3WGoqOos-7VY6vvEg',
        //     appId: '1:750706326635:android:03edfeceb089a74d85452e',
        //     messagingSenderId: '750706326635',
        //     projectId: 'shift-uat',
        //     storageBucket: 'shift-uat.appspot.com',
        //   ),
        // );
        await Firebase.initializeApp();
        _initialized = true;
      } catch (e) {
        debugPrint('Firebase initialization error: $e');
      }
    }
  }

  /// Requests notification permission and retrieves the FCM registration token.
  Future<String?> getFcmToken() async {
    try {
      await initializeFirebase();
      final messaging = FirebaseMessaging.instance;

      // 1. Request permission for notifications (required for iOS and Android 13+)
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('FCM Authorization Status: ${settings.authorizationStatus}');

      // 2. Retrieve FCM Token (Android can always get token; iOS requires APNS on real devices)
      final String? token = await messaging.getToken();
      debugPrint('🔥 FCM Token: $token');
      return token;
    } catch (e, stackTrace) {
      debugPrint('❌ Error retrieving FCM Token: $e\n$stackTrace');
      return null;
    }
  }

  /// Listens for token refreshes and executes [onTokenRefreshed] callback when refreshed.
  void listenToTokenRefresh(void Function(String token) onTokenRefreshed) {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      debugPrint('🔄 FCM Token Refreshed: $newToken');
      onTokenRefreshed(newToken);
    });
  }
}
