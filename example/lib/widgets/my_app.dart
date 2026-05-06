import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _locale = Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: Scaffold(
        appBar: AppBar(title: const Text('arb_generator')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                SegmentedButton(
                  segments: AppLocalizations.supportedLocales
                      .map(
                        (locale) => ButtonSegment(
                          value: locale,
                          label: Text(locale.toString()),
                        ),
                      )
                      .toList(),
                  selected: {_locale},
                  onSelectionChanged: (newSelection) =>
                      setState(() => _locale = newSelection.first),
                ),
                const HomeScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppLocalizations.of(context)!.myKey),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.welcome('Dash')),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.numberMessages(0)),
        Text(AppLocalizations.of(context)!.numberMessages(1)),
        Text(AppLocalizations.of(context)!.numberMessages(2)),
        Text(AppLocalizations.of(context)!.numberMessages(5)),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.whoseBook('male')),
        Text(AppLocalizations.of(context)!.whoseBook('female')),
        Text(AppLocalizations.of(context)!.whoseBook('other')),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.unreadEmails(0, 'Dash')),
        Text(AppLocalizations.of(context)!.unreadEmails(1, 'Dash')),
        Text(AppLocalizations.of(context)!.unreadEmails(42, 'Dash')),
        const SizedBox(height: 8),
        Text(AppLocalizations.of(context)!.weatherReaction('sunny')),
        Text(AppLocalizations.of(context)!.weatherReaction('cloudy')),
        Text(AppLocalizations.of(context)!.weatherReaction('rainy')),
      ],
    );
  }
}
