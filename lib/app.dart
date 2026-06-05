import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:alarme_feriados/features/alarme_tocando/alarme_tocando_page.dart';
import 'package:alarme_feriados/features/home/home_page.dart';
import 'package:alarme_feriados/services/alarm_service.dart';
import 'package:alarme_feriados/services/reagendador.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final StreamSubscription<AlarmRingEvent> _ringSubscription;

  @override
  void initState() {
    super.initState();
    _ringSubscription = AlarmService.ringStream.listen(_onAlarmRing);
  }

  @override
  void dispose() {
    _ringSubscription.cancel();
    super.dispose();
  }

  void _onAlarmRing(AlarmRingEvent event) {
    Reagendador.validarDisparo(event.id).then((deve) {
      if (!deve) return;
      _navigatorKey.currentState?.push(
        CupertinoPageRoute<void>(
          fullscreenDialog: true,
          builder: (_) => AlarmeTocandoPage(
            alarmId: event.id,
            titulo: event.titulo,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      navigatorKey: _navigatorKey,
      title: 'Alarme Feriados',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemOrange,
      ),
      home: const HomePage(),
    );
  }
}
