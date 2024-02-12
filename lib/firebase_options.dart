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
    apiKey: 'AIzaSyCt5VsoIdCz8-_jphYP7MbecAhi3Ox4N9c',
    appId: '1:898406101191:web:153d0defe2bb88dcbd4ee2',
    messagingSenderId: '898406101191',
    projectId: 'sef-assignment-223b2',
    authDomain: 'sef-assignment-223b2.firebaseapp.com',
    storageBucket: 'sef-assignment-223b2.appspot.com',
    measurementId: 'G-DWZMPX4KTR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-twLo9Mz6r-YeXFH8zV9VPP-CBLipB18',
    appId: '1:898406101191:android:b90fe97bd31c8288bd4ee2',
    messagingSenderId: '898406101191',
    projectId: 'sef-assignment-223b2',
    storageBucket: 'sef-assignment-223b2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYbsU7Ro7qRUuooBr-fcMGBaYxrr1vyG4',
    appId: '1:898406101191:ios:eebc5ea966932144bd4ee2',
    messagingSenderId: '898406101191',
    projectId: 'sef-assignment-223b2',
    storageBucket: 'sef-assignment-223b2.appspot.com',
    iosBundleId: 'com.example.testFirebaseeeeee',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYbsU7Ro7qRUuooBr-fcMGBaYxrr1vyG4',
    appId: '1:898406101191:ios:5f1d733dc43fe31cbd4ee2',
    messagingSenderId: '898406101191',
    projectId: 'sef-assignment-223b2',
    storageBucket: 'sef-assignment-223b2.appspot.com',
    iosBundleId: 'com.example.testFirebaseeeeee.RunnerTests',
  );
}
