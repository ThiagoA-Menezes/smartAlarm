import 'dart:io' show Platform;

import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'package:alarme_feriados/app.dart';
import 'package:alarme_feriados/features/configuracoes/configuracoes_providers.dart';
import 'package:alarme_feriados/services/reagendador.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, _) async {
    await Alarm.init(showDebugLogs: false);
    await Reagendador.executar();
    return true;
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init(showDebugLogs: false);

  if (Platform.isAndroid) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager()
        .registerPeriodicTask(
          Reagendador.taskId,
          Reagendador.taskId,
          frequency: const Duration(hours: 24),
          initialDelay: const Duration(minutes: 1),
          existingWorkPolicy: ExistingWorkPolicy.keep,
        )
        .ignore();
  }

  final prefs = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const App(),
    ),
  );
}
