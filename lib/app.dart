import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show MissingPluginException, PlatformException;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static const _prefPermissoesSolicitadas = 'permissoes_solicitadas';

  @override
  void initState() {
    super.initState();
    _ringSubscription = AlarmService.ringStream.listen(_onAlarmRing);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _solicitarPermissoesPrimeiraVez();
    });
  }

  /// Na primeira abertura, explica e pede ao usuário a permissão para o
  /// alarme tocar no horário exato (diálogo nativo do sistema na sequência).
  Future<void> _solicitarPermissoesPrimeiraVez() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(_prefPermissoesSolicitadas) ?? false) return;

      final context = _navigatorKey.currentContext;
      if (context == null || !context.mounted) return;

      final aceitou = await showCupertinoDialog<bool>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Permitir alarmes'),
          content: const Text(
            'Para que o alarme toque no horário programado, o app precisa '
            'da sua permissão para notificações e alarmes exatos.',
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Agora não'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Permitir'),
            ),
          ],
        ),
      );

      if (aceitou == true) {
        await AlarmService.solicitarPermissoes();
      }

      final ctxGps = _navigatorKey.currentContext;
      if (ctxGps != null && ctxGps.mounted) {
        final aceitouGps = await showCupertinoDialog<bool>(
          context: ctxGps,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Usar sua localização'),
            content: const Text(
              'Com sua localização, o app aplica automaticamente os '
              'feriados estaduais e municipais da sua cidade.',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Agora não'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Permitir'),
              ),
            ],
          ),
        );
        if (aceitouGps == true) {
          await Permission.locationWhenInUse.request();
        }
      }

      await prefs.setBool(_prefPermissoesSolicitadas, true);
    } on MissingPluginException {
      // Engine indisponível em testes host
    } on PlatformException {
      // Canal nativo indisponível nesta plataforma
    }
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
