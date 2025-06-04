import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestonesto/app/app.dart';
import 'package:prestonesto/utils/config_reader.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'package:prestonesto/utils/auth_persistence.dart';
import 'package:prestonesto/auth/api_auth/models/api_auth_user.dart';
import 'flutter_flow/nav/nav.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> mainCommon(String env) async {
  // Loading .env file from root directory.
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  // Initialize Firebase to avoid errors
  await Firebase.initializeApp();

  await ConfigReader.initialize(env);
  await actions.portraitLock();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  // Check for previous login and update AppStateNotifier
  if (await hasLoggedInBefore()) {
    AppStateNotifier.instance.user = ApiAuthUser(
      email: '', // Optionally fill with stored/fetched info
      phoneNumber: '',
    );
  }

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
