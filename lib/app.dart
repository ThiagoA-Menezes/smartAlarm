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

  /// Na primeira abertura, explica e pede as permissões de alarme e de
  /// localização (diálogo do app seguido do diálogo nativo do sistema).
  /// Cada pedido é isolado: falha em um (ex: AlarmKit indisponível no
  /// simulador) não impede o outro.
  Future<void> _solicitarPermissoesPrimeiraVez() async {
    final SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } on MissingPluginException {
      return; // Engine indisponível em testes host
    }
    if (prefs.getBool(_prefPermissoesSolicitadas) ?? false) return;

    final aceitouAlarme = await _perguntar(
      titulo: 'Permitir alarmes',
      mensagem:
          'Para que o alarme toque no horário programado, o app precisa '
          'da sua permissão para notificações e alarmes exatos.',
    );
    if (aceitouAlarme) {
      try {
        await AlarmService.solicitarPermissoes();
      } on MissingPluginException {
        // AlarmKit indisponível (simulador iOS / testes host)
      } on PlatformException {
        // Canal nativo indisponível nesta plataforma
      }
    }

    final aceitouGps = await _perguntar(
      titulo: 'Usar sua localização',
      mensagem: 'Com sua localização, o app aplica automaticamente os '
          'feriados estaduais e municipais da sua cidade.',
    );
    if (aceitouGps) {
      try {
        await Permission.locationWhenInUse.request();
      } on MissingPluginException {
        // Plugin indisponível em testes host
      } on PlatformException {
        // Plataforma sem suporte
      }
    }

    await prefs.setBool(_prefPermissoesSolicitadas, true);
  }

  Future<bool> _perguntar({
    required String titulo,
    required String mensagem,
  }) async {
    final context = _navigatorKey.currentContext;
    if (context == null || !context.mounted) return false;
    final resposta = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
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
    return resposta ?? false;
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
