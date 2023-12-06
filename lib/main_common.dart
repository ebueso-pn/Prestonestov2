import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestonesto_v1/app/app.dart';
import 'package:prestonesto_v1/app/push_notifications_service.dart';
import 'package:prestonesto_v1/utils/config_reader.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/firebase_app_check_util.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  await initFirebase();

  await ConfigReader.initialize(env);
  // Start initial custom actions code
  await actions.portraitLock();
  // End initial custom actions code

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  await initializeFirebaseAppCheck();

  await PushNotificationService().setupInteractedMessage();

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received a notification when it was killed
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then(
    (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}
