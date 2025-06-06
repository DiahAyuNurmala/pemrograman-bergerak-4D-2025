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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyAtGAaFbXVaPD5BqaFz-NCTWb8mqp5ICLk',
    appId: '1:744498145929:web:011fe82c0c2c3212e73458',
    messagingSenderId: '744498145929',
    projectId: 'latihan-flutter-36ef4',
    authDomain: 'latihan-flutter-36ef4.firebaseapp.com',
    storageBucket: 'latihan-flutter-36ef4.firebasestorage.app',
    measurementId: 'G-R1M28SCC3T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBWCAgToph4dsrBjbSdxPOazyYUvA-4Jss',
    appId: '1:744498145929:android:49607c8265f80daae73458',
    messagingSenderId: '744498145929',
    projectId: 'latihan-flutter-36ef4',
    storageBucket: 'latihan-flutter-36ef4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuPh7Z3ii7a_0uUtbj11spHKez7Kcac7Y',
    appId: '1:744498145929:ios:0ba99f534f28b39de73458',
    messagingSenderId: '744498145929',
    projectId: 'latihan-flutter-36ef4',
    storageBucket: 'latihan-flutter-36ef4.firebasestorage.app',
    iosBundleId: 'com.example.modul5',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuPh7Z3ii7a_0uUtbj11spHKez7Kcac7Y',
    appId: '1:744498145929:ios:0ba99f534f28b39de73458',
    messagingSenderId: '744498145929',
    projectId: 'latihan-flutter-36ef4',
    storageBucket: 'latihan-flutter-36ef4.firebasestorage.app',
    iosBundleId: 'com.example.modul5',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtGAaFbXVaPD5BqaFz-NCTWb8mqp5ICLk',
    appId: '1:744498145929:web:83578cbb2a95195ae73458',
    messagingSenderId: '744498145929',
    projectId: 'latihan-flutter-36ef4',
    authDomain: 'latihan-flutter-36ef4.firebaseapp.com',
    storageBucket: 'latihan-flutter-36ef4.firebasestorage.app',
    measurementId: 'G-JHYLJF8JVN',
  );
}
