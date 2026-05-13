import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDY5UixCBS5AQqjchivPmt5VWHVc_XGlVw',
    appId: "1:635565556562:web:571ace6eac36b2cad2708b",
    messagingSenderId: '635565556562',
    projectId: 'takedat-211d6',
    authDomain: "takedat-211d6.firebaseapp.com",
    storageBucket: 'takedat-211d6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDY5UixCBS5AQqjchivPmt5VWHVc_XGlVw',
    appId: "1:635565556562:web:571ace6eac36b2cad2708b",
    messagingSenderId: '635565556562',
    projectId: 'takedat-211d6',
    storageBucket: 'takedat-211d6.firebasestorage.app',
  );
}
