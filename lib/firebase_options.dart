// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBd6u0R4rRuOV8ceBKdv-XRrL1X5_gr54',
    appId: '1:789960705338:web:1fda65a9663d2b87f9fc03',
    messagingSenderId: '789960705338',
    projectId: 'turfapp-297a6',
    authDomain: 'turfapp-297a6.firebaseapp.com',
    storageBucket: 'turfapp-297a6.appspot.com',
    measurementId: 'G-7KVJC4K7WY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC79_LSN0t_w32RtD9LBBkTnTFLi3virms',
    appId: '1:789960705338:android:227beb3e87f81f0df9fc03',
    messagingSenderId: '789960705338',
    projectId: 'turfapp-297a6',
    storageBucket: 'turfapp-297a6.appspot.com',
  );
}
