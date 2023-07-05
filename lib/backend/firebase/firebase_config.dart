import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD93ySO8LEyfOtOU62Hd9dsdLHcB_mm9nM",
            authDomain: "prestonesto-af804.firebaseapp.com",
            projectId: "prestonesto-af804",
            storageBucket: "prestonesto-af804.appspot.com",
            messagingSenderId: "984117236759",
            appId: "1:984117236759:web:3e9e6c3cb94c97d7223852",
            measurementId: "G-M1N4T5W1M8"));
  } else {
    await Firebase.initializeApp();
  }
}
