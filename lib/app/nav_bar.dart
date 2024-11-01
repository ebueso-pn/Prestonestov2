import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:prestonesto/application/application_carrousel/application_carrousel_screen.dart';
import 'package:prestonesto/application/application_documents/application_documents_screen.dart';
import 'package:prestonesto/auth/firebase_auth/auth_util.dart';
import 'package:prestonesto/backend/backend.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_theme.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_util.dart';
import 'package:prestonesto/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Applicaiton_Summary';
  late Widget? _currentPage;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Map<int, Widget> _applicationTabs = {};
  Map<int, String> _applicationTabsNames = {};
  String appStatus = 'CONTINUE_NO_SCORE';
  ApplicationRecord? applicationIniciada;
  int _applicationIndex = 0;
  bool useInitialPage = true;

  @override
  void initState() {
    super.initState();
    analytics.setAnalyticsCollectionEnabled(true);
    _currentPage = widget.page;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getLastInitiatedApplication();
      await _getEquifaxStatus();
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> _getLastInitiatedApplication() async {
    final data = await queryApplicationRecordOnce(
        parent: currentUserReference,
        limit: 1,
        queryBuilder: (applicationRecord) => applicationRecord
            .where('status', isEqualTo: 'Iniciada')
            .orderBy('date_applied', descending: true));
    if (data.isNotEmpty) {
      applicationIniciada = data.first;
    }
  }

  Future<void> _getEquifaxStatus() async {
    if (applicationIniciada != null) {
      final data = await EquifaxRecord.collection
          .where('ApplicationDocReference',
              isEqualTo: applicationIniciada!.reference)
          .limit(1)
          .get();
      if (data.docs.isNotEmpty) {
        final equifaxData = data.docs.first.data() as Map<String, dynamic>;
        int? score;
        try {
          score = int.tryParse(
              equifaxData['infoCrediticia']['ScoreActual'][0]['SCORE']);
        } catch (e) {
          return;
        }
        if (score == null) {
          return;
        }
        if (score >= 790) {
          appStatus = 'CONTINUE';
        } else if (score > 0) {
          appStatus = 'DENEGADA';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (applicationIniciada != null) {
      _applicationIndex =
          (0 > applicationIniciada!.index && applicationIniciada!.index > 5)
              ? 0
              : applicationIniciada!.index;
      _applicationTabs = {
        0: ApplicaitonSummaryWidget(),
        1: ApplicationLoanCalculatorWidget(
            applicationRecieve: applicationIniciada!.reference,
            equifaxStatus: appStatus),
        2: ApplicationAddressWidget(
            applicationRecieve: applicationIniciada!.reference,
            equifaxStatus: appStatus),
        3: ApplicationMapWidget(
            applicationRecieve: applicationIniciada!.reference,
            equifaxStatus: appStatus),
        4: ApplicationCarrouselWidget(
            applicationRecieve: applicationIniciada!.reference,
            equifaxStatus: appStatus),
        5: ApplicationDocuments(
            applicationRecieve: applicationIniciada!.reference,
            equifaxStatus: appStatus),
        6: ApplicationReviewWidget(
            applicationRecieve: applicationIniciada!.reference,
            equifaxStatus: appStatus),
      };
      _applicationTabsNames = {
        0: 'Applicaiton_Summary',
        1: 'Application_LoanCalculator',
        2: 'Application_Address',
        3: 'Application_Map',
        4: 'Application_Carrousel',
        5: 'Application_UploadDocs',
        6: 'Application_Review',
      };
    } else {
      _applicationTabs = {
        0: ApplicaitonSummaryWidget(),
      };
      _applicationTabsNames = {
        0: 'Applicaiton_Summary',
      };
    }
    if (_currentPageName == 'Applicaiton_Summary' &&
        applicationIniciada != null) {
      _currentPageName = _applicationTabsNames[_applicationIndex]!;
    }
    if (useInitialPage &&
        !_applicationTabsNames.containsValue(widget.initialPage))
      _currentPageName = widget.initialPage ?? _currentPageName;

    print('Current page: $_currentPageName');
    print('Initial page: ${widget.initialPage}');
    print('Current index: $_applicationIndex');
    print('Current status: $appStatus');
    print('Current application: $applicationIniciada');
    print('Current application tabs: $_applicationTabs');
    print('Current application tabs names: $_applicationTabsNames');

    final Map<String, Widget> tabs = {
      'Home': HomeWidget(),
      (_applicationTabsNames[_applicationIndex] ?? 'Applicaiton_Summary'):
          (_applicationTabs[_applicationIndex] ?? ApplicaitonSummaryWidget()),
      'Profile': ProfileWidget(),
    };

    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    print('TABS: $tabs');
    print('Current index: $currentIndex');
    print('Current page: ${tabs.keys.toList()[currentIndex]}');

    Future<bool> _hasActiveLoans() async {
      final loans = queryLoansRecord(
        queryBuilder: (loansRecord) => loansRecord.where('UserDocReference',
            isEqualTo: currentUserReference),
        singleRecord: true,
      );

      LoansRecord? loan;
      await for (final aux in loans) {
        loan = aux.first;
        break;
      }
      bool isBlocked = await _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool('loanScreenCounterBlock') ?? false);
      });
      return (loan != null && loan.status == 'Firmado' && !isBlocked);
    }

    Future<void> _incrementCounter() async {
      final SharedPreferences prefs = await _prefs;
      final int counter = (prefs.getInt('loanScreenCounter') ?? 0) + 1;

      setState(() {
        prefs.setInt('loanScreenCounter', counter);
      });
    }

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: Visibility(
        visible: responsiveVisibility(
          context: context,
          desktop: false,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (i) async {
            setState(() {
              _currentPage = null;
              _currentPageName = tabs.keys.toList()[i];
              useInitialPage = false;
            });
            if (_currentPageName == 'Home' && await _hasActiveLoans()) {
              print('Incrementing counter');
              _incrementCounter();
            }
          },
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
