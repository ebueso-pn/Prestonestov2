import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/features/home/view.dart';

class NavBarPage extends StatefulWidget {
  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = FFAppState().currentUser;

    // If user is not loaded, show loading
    if (user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If user has no active loans and no application, show HomePage only (no nav bar)
    if (!user.hasActiveLoans && !user.hasApplication) {
      return HomePage();
    }

    // Otherwise, show nav bar with Loans and Profile tabs
    final tabs = [
      HomePage(), // Loans tab
      Placeholder(), // Profile tab (replace with your ProfilePage)
    ];

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Loans',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
