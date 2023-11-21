import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import './diagram_screen.dart';
import './prediction_screen.dart';
import './statistics_screen.dart';

class Page {
  final Widget body;
  final PreferredSizeWidget? appBar;

  Page({required this.body, this.appBar});
}

class TabScreen extends StatefulWidget {
  static const routeName = 'tab_screen';
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Page> _pages;
  int _selectedPageIndex = 0;

  void _logoutAndRedirect(BuildContext context) async {
    final authData = Provider.of<Auth>(context, listen: false);

    // Sikeres kijelentkezés üzenet
    _showLogoutSuccessDialog(context);

    // Várunk 1 másodpercet
    await Future.delayed(Duration(seconds: 1));

    // Vissza a bejelentkező képernyőre
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _showLogoutSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Successful logout'),
        content: Text('You have been successfully logged out.'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      Page(
        body: DiagramScreen(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Diagram'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _logoutAndRedirect(context),
            ),
          ],
        ),
      ),
      Page(
        body: PredictionScreen(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Prediction'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _logoutAndRedirect(context),
            ),
          ],
        ),
      ),
      Page(
        body: StatisticsScreen(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Statistics'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => _logoutAndRedirect(context),
              color: Color(0xFFf1faee),
            ),
          ],
        ),
      ),
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_selectedPageIndex].appBar,
      body: _pages[_selectedPageIndex].body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: const Color(0xFFf1faee),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Diagram',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.online_prediction),
            label: 'Prediction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}
