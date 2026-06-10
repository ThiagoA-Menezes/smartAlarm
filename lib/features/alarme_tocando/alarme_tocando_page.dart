import 'package:flutter/cupertino.dart';

import 'package:alarme_feriados/services/alarm_service.dart';

class AlarmeTocandoPage extends StatelessWidget {
  final int alarmId;
  final String titulo;

  const AlarmeTocandoPage({
    super.key,
    required this.alarmId,
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.black,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                CupertinoIcons.alarm_fill,
                size: 96,
                color: CupertinoColors.white,
              ),
              Text(
                titulo.isEmpty ? 'Alarme Feriados' : titulo,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _BotaoAcao(
                    label: 'Soneca\n10 min',
                    icon: CupertinoIcons.moon_zzz_fill,
                    onTap: () => _soneca(context),
                  ),
                  _BotaoAcao(
                    label: 'Parar',
                    icon: CupertinoIcons.stop_circle_fill,
                    onTap: () => _parar(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _parar(BuildContext context) async {
    await AlarmService.cancelar(alarmId);
    if (context.mounted) Navigator.of(context).pop();
  }

  Future<void> _soneca(BuildContext context) async {
    await AlarmService.soneca(alarmId);
    if (context.mounted) Navigator.of(context).pop();
  }
}

class _BotaoAcao extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _BotaoAcao({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x33FFFFFF),
            ),
            child: Icon(icon, size: 40, color: CupertinoColors.white),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
                color: CupertinoColors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
