import 'dart:async';
import 'dart:io' show Platform;

import 'package:alarm/alarm.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:permission_handler/permission_handler.dart';

class AlarmRingEvent {
  const AlarmRingEvent({required this.id, required this.titulo});

  final int id;
  final String titulo;
}

class AlarmService {
  static Stream<AlarmRingEvent> get ringStream {
    return Alarm.ringStream.stream.map(
      (s) => AlarmRingEvent(id: s.id, titulo: s.notificationSettings.title),
    );
  }

  static Future<bool> solicitarPermissoes() async {
    try {
      final notifications = await Permission.notification.request();
      final exactAlarm = await Permission.scheduleExactAlarm.request();
      return notifications.isGranted && exactAlarm.isGranted;
    } on PlatformException {
      return false;
    }
  }

  static Future<void> agendar({
    required int id,
    required DateTime dateTime,
    String titulo = '',
  }) async {
    if (!Platform.isIOS && !Platform.isAndroid) return;
    await Alarm.set(
      alarmSettings: AlarmSettings(
        id: id,
        dateTime: dateTime,
        assetAudioPath: 'assets/audio/alarme.mp3',
        loopAudio: true,
        vibrate: true,
        fadeDuration: 3.0,
        androidFullScreenIntent: true,
        notificationSettings: NotificationSettings(
          title: titulo.isEmpty ? 'Alarme Feriados' : titulo,
          body: 'Toque para parar o alarme',
          stopButton: 'Parar',
        ),
      ),
    );
  }

  static Future<void> cancelar(int id) async {
    if (!Platform.isIOS && !Platform.isAndroid) return;
    await Alarm.stop(id);
  }

  static Future<void> soneca(int id, {int minutos = 10}) async {
    await cancelar(id);
    await agendar(
      id: id,
      dateTime: DateTime.now().add(Duration(minutes: minutos)),
    );
  }
}
