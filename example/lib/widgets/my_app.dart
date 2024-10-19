import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(_locale),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('arb_generator'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final locale in AppLocalizations.supportedLocales) ...[
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => _locale = locale.toString()),
                      child: Text(locale.toString()),
                    ),
                    const SizedBox(width: 8),
                  ]
                ],
              ),
              const SizedBox(height: 8),
              const HomeScreen(),
            ],
          ),
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
