import 'package:example/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _locale;

  @override
  void initState() {
    super.initState();

    _locale = 'en';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      locale: Locale(_locale),
      home: Scaffold(
        appBar: AppBar(
          title: Text('ARB Generator'),
        ),
        body: Column(
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final locale in AppLocalizations.delegate.supportedLocales) ...[
                  ElevatedButton(
                    onPressed: () => setState(() => _locale = locale.toString()),
                    child: Text(locale.toString()),
                  ),
                  SizedBox(width: 8),
                ]
              ],
            ),
            SizedBox(height: 8),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context).myKey),
          SizedBox(height: 8),
          Text(AppLocalizations.of(context).welcome('Dash')),
          SizedBox(height: 8),
          Text(AppLocalizations.of(context).numberMessages(0)),
          Text(AppLocalizations.of(context).numberMessages(1)),
          Text(AppLocalizations.of(context).numberMessages(2)),
          Text(AppLocalizations.of(context).numberMessages(5)),
          SizedBox(height: 8),
          Text(AppLocalizations.of(context).whoseBook('male')),
          Text(AppLocalizations.of(context).whoseBook('female')),
          Text(AppLocalizations.of(context).whoseBook('other')),
          SizedBox(height: 8),
          Text(AppLocalizations.of(context).unreadEmails(0, 'Dash')),
          Text(AppLocalizations.of(context).unreadEmails(1, 'Dash')),
          Text(AppLocalizations.of(context).unreadEmails(42, 'Dash')),
        ],
      ),
    );
  }
}
