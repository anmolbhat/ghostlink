// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
// / // ...
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
/// ```
class Global{
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  }
}

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
    apiKey: 'AIzaSyBIemm8ed9YBF88nRIZKu3tVkxHnm-BduM',
    appId: '1:254117104959:web:864a558d0186e6db48978a',
    messagingSenderId: '254117104959',
    projectId: 'ciphat-27be6',
    authDomain: 'ciphat-27be6.firebaseapp.com',
    storageBucket: 'ciphat-27be6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5-NpZotYephCfXt9l1VklvZK8pNAI4Ss',
    appId: '1:254117104959:android:139285e3ce8fc4e248978a',
    messagingSenderId: '254117104959',
    projectId: 'ciphat-27be6',
    storageBucket: 'ciphat-27be6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD50chyvCNYVBzht7X8iCRwBv9w2MeO6IQ',
    appId: '1:254117104959:ios:63baaa4229fdf0f548978a',
    messagingSenderId: '254117104959',
    projectId: 'ciphat-27be6',
    storageBucket: 'ciphat-27be6.appspot.com',
    iosClientId: '254117104959-vme3grqnm7gbojq15mj7075mh9jd0hbf.apps.googleusercontent.com',
    iosBundleId: 'com.abnhmaotl.ciphat.ciphat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD50chyvCNYVBzht7X8iCRwBv9w2MeO6IQ',
    appId: '1:254117104959:ios:63baaa4229fdf0f548978a',
    messagingSenderId: '254117104959',
    projectId: 'ciphat-27be6',
    storageBucket: 'ciphat-27be6.appspot.com',
    iosClientId: '254117104959-vme3grqnm7gbojq15mj7075mh9jd0hbf.apps.googleusercontent.com',
    iosBundleId: 'com.abnhmaotl.ciphat.ciphat',
  );
}
