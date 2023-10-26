import 'package:flutter/services.dart';
import 'package:prestonesto_v1/backend/backend.dart';

import '/custom_code/actions/index.dart' as actions;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'flutter_flow/firebase_app_check_util.dart';
import 'index.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

  // Start initial custom actions code
  await actions.portraitLock();
  // End initial custom actions code

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  await initializeFirebaseAppCheck();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

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
      title: 'PrestonestoV1',
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

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Application_LoanCalculator';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'Home': HomeWidget(),
      'Application_LoanCalculator': ApplicationLoanCalculatorWidget(),
      'Profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: Visibility(
        visible: responsiveVisibility(
          context: context,
          desktop: false,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
          backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
          selectedItemColor: FlutterFlowTheme.of(context).primary,
          unselectedItemColor: FlutterFlowTheme.of(context).secondaryText,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                size: 24.0,
              ),
              label: 'Prestamos',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.app_registration,
                size: 24.0,
              ),
              label: 'Solicitud',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
                size: 28.0,
              ),
              label: 'Perfil',
              tooltip: '',
            )
          ],
        ),
      ),
    );
  }
}
