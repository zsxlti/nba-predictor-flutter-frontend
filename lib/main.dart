import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/stats.dart';
import '../providers/games.dart';
import '../providers/comparison.dart';

import './screens/authentication_screen.dart';
import './screens/tab_screen.dart';

void main() {
  runApp(NbaPredictor());
}

class NbaPredictor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Diagram(),
        ),
        ChangeNotifierProvider(
          create: (_) => Games(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => Comparison(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFf1faee),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
            accentColor: const Color(0xffe63946),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Color(0xFFf1faee),
              fontSize: 20,
            ),
          ),
        ),
        routes: {
          '/': (context) => AuthenticationScreen(),
          TabScreen.routeName: (context) => TabScreen(),
        },
      ),
    );
  }
}
