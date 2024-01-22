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
    apiKey: 'AIzaSyB8mWnLqe0vEkNfmgCjUtTNhVuRjSbalAE',
    appId: '1:703904848886:web:d3e7e2f7e31956dd3e45d7',
    messagingSenderId: '703904848886',
    projectId: 'simple-cupertino-chat-app',
    authDomain: 'simple-cupertino-chat-app.firebaseapp.com',
    storageBucket: 'simple-cupertino-chat-app.appspot.com',
    measurementId: 'G-6FMZ6PQTXJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfYvlpqIdZDhjVYn_5cUa8gTGtmzWc5bA',
    appId: '1:703904848886:android:674897facf3e2efe3e45d7',
    messagingSenderId: '703904848886',
    projectId: 'simple-cupertino-chat-app',
    storageBucket: 'simple-cupertino-chat-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBY9ggWtYY8nAqlOCVFX8Ep8Eo8cH6vPK8',
    appId: '1:703904848886:ios:473ade7c4f27c4b93e45d7',
    messagingSenderId: '703904848886',
    projectId: 'simple-cupertino-chat-app',
    storageBucket: 'simple-cupertino-chat-app.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBY9ggWtYY8nAqlOCVFX8Ep8Eo8cH6vPK8',
    appId: '1:703904848886:ios:d11dc29655804d073e45d7',
    messagingSenderId: '703904848886',
    projectId: 'simple-cupertino-chat-app',
    storageBucket: 'simple-cupertino-chat-app.appspot.com',
    iosBundleId: 'com.example.flutterApp.RunnerTests',
  );
}