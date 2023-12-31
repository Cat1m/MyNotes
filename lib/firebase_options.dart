// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBJo7GnLmDZ7kTSa9zhh17fqNbPul-7L98',
    appId: '1:324035854660:web:61bc922f56230c58491711',
    messagingSenderId: '324035854660',
    projectId: 'chien-notes',
    authDomain: 'chien-notes.firebaseapp.com',
    storageBucket: 'chien-notes.appspot.com',
    measurementId: 'G-79VQYC1XFF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuhK1gkGV_GBPjvNI8MmJyBp3xBoACe5Y',
    appId: '1:324035854660:android:a9722a90042ce03e491711',
    messagingSenderId: '324035854660',
    projectId: 'chien-notes',
    storageBucket: 'chien-notes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4dfmp0qsK503QcSaUUKZ5sXVjLUGdWlc',
    appId: '1:324035854660:ios:60d604dd4cd87fa6491711',
    messagingSenderId: '324035854660',
    projectId: 'chien-notes',
    storageBucket: 'chien-notes.appspot.com',
    iosBundleId: 'com.catim.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4dfmp0qsK503QcSaUUKZ5sXVjLUGdWlc',
    appId: '1:324035854660:ios:9a8a90592200b679491711',
    messagingSenderId: '324035854660',
    projectId: 'chien-notes',
    storageBucket: 'chien-notes.appspot.com',
    iosBundleId: 'com.catim.mynotes.RunnerTests',
  );
}
