import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:prestonesto/application/application_loan_calculator/application_loan_calculator_widget.dart';
import 'package:prestonesto/auth/firebase_auth/auth_util.dart';
import 'package:prestonesto/backend/backend.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_theme.dart';
import 'package:prestonesto/flutter_flow/flutter_flow_util.dart';
import 'package:prestonesto/home/home_widget.dart';
import 'package:prestonesto/profile/profile/profile_widget.dart';
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
  String _currentPageName = 'Application_LoanCalculator';
  late Widget? _currentPage;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    analytics.setAnalyticsCollectionEnabled(true);
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
