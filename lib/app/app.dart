import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prestonesto_v1/app/app_state.dart';
import 'package:prestonesto_v1/auth/firebase_auth/auth_util.dart';
import 'package:prestonesto_v1/auth/firebase_auth/firebase_user_provider.dart';
import 'package:prestonesto_v1/backend/backend.dart';
import 'package:prestonesto_v1/flutter_flow/internationalization.dart';
import 'package:prestonesto_v1/flutter_flow/nav/nav.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    /*
      Note : Make sure to remove FlutterBranchSdk.validateSDKIntegration() in your production build.
    */
    FlutterBranchSdk.validateSDKIntegration();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = prestonestoV1FirebaseUserStream()
      ..listen((user) async {
        _appStateNotifier.update(user);
        FFAppState().userHasIncomeVerification =
            await checkUserHasIncomeVerification();
        FFAppState().userHasBankAccount = await checkUserHasBankAccount();
        FFAppState().userHasPersonalEvaluationCompleted =
            await checkUserAlreadyCompletedPersonalEvaluation();
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
    FlutterBranchSdk.initSession().listen((data) {
      if (data.containsKey('begini_success') &&
          data['begini_success'] == 'true') {
        FFAppState().userHasPersonalEvaluationCompleted = true;
        updateUserPersonalEvaluation(true);
        _router.go('/beginiSuccess');
      }
      if (data.containsKey('zapsign_success') &&
          data['zapsign_success'] == 'true') {
        _router.go('/loanSignatureSuccess');
      }
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print('${platformException.code} - ${platformException.message}');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FFAppState().userHasIncomeVerification =
          await checkUserHasIncomeVerification();
      FFAppState().userHasBankAccount = await checkUserHasBankAccount();
      FFAppState().userHasPersonalEvaluationCompleted =
          await checkUserAlreadyCompletedPersonalEvaluation();
      setState(() {});
    });
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Prestonesto',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('es'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}
