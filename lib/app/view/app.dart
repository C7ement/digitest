import 'package:digitest/assets/l10n/l10n.dart';
import 'package:digitest/views/counter/view/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFFFCB041)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFFFCB041),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const DashboardPage(),
    );
  }
}
