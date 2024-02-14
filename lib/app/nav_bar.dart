import 'package:flutter/material.dart';
import 'package:prestonesto_v1/application/application_loan_calculator/application_loan_calculator_widget.dart';
import 'package:prestonesto_v1/flutter_flow/flutter_flow_theme.dart';
import 'package:prestonesto_v1/flutter_flow/flutter_flow_util.dart';
import 'package:prestonesto_v1/home/home_widget.dart';
import 'package:prestonesto_v1/profile/profile/profile_widget.dart';

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
