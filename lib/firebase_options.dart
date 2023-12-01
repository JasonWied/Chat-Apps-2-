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
    apiKey: 'AIzaSyAcuqoyOP0F56K72YbNA3PU9ZJywIbxfQY',
    appId: '1:100476692203:web:9bf9e1a6713cb3672c40ae',
    messagingSenderId: '100476692203',
    projectId: 'chatappsuas',
    authDomain: 'chatappsuas.firebaseapp.com',
    databaseURL: 'https://chatappsuas-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatappsuas.appspot.com',
    measurementId: 'G-4QDWBFEDEC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADhm9_3avEGXe53neABrgfUBiOWhyext0',
    appId: '1:100476692203:android:bf39b8884a8df74c2c40ae',
    messagingSenderId: '100476692203',
    projectId: 'chatappsuas',
    databaseURL: 'https://chatappsuas-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatappsuas.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANg49mi-OSfStsaweIgVUXqe1I2UgpqnE',
    appId: '1:100476692203:ios:0dfa62adacf612272c40ae',
    messagingSenderId: '100476692203',
    projectId: 'chatappsuas',
    databaseURL: 'https://chatappsuas-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatappsuas.appspot.com',
    iosBundleId: 'com.example.chatappsuas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANg49mi-OSfStsaweIgVUXqe1I2UgpqnE',
    appId: '1:100476692203:ios:05965378a0b28fd82c40ae',
    messagingSenderId: '100476692203',
    projectId: 'chatappsuas',
    databaseURL: 'https://chatappsuas-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'chatappsuas.appspot.com',
    iosBundleId: 'com.example.chatappsuas.RunnerTests',
  );
}
