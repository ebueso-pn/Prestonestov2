import 'package:firebase_app_check/firebase_app_check.dart';

Future initializeFirebaseAppCheck() => FirebaseAppCheck.instance.activate(
      webProvider:
          ReCaptchaV3Provider('6Leq5tcmAAAAALvmFKn9o2N87wpxwsQEVnEeZtcM'),
      androidProvider: AndroidProvider.playIntegrity,
    );
