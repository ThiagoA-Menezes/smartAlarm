import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissoesStatusProvider =
    FutureProvider<Map<String, bool>>((ref) async {
  try {
    if (Platform.isAndroid) {
      return {
        'alarme':
            (await Permission.scheduleExactAlarm.status).isGranted,
        'notificacao':
            (await Permission.notification.status).isGranted,
        'localizacao':
            (await Permission.locationWhenInUse.status).isGranted,
        'bateria': (await Permission.ignoreBatteryOptimizations.status)
            .isGranted,
      };
    }
    if (Platform.isIOS) {
      return {
        'localizacao':
            (await Permission.locationWhenInUse.status).isGranted,
      };
    }
    return {};
  } catch (_) {
    return {};
  }
});

class PermissoesPage extends ConsumerWidget {
  const PermissoesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(permissoesStatusProvider);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
          middle: Text('Permissões e bateria')),
      child: SafeArea(
        top: false,
        child: statusAsync.when(
          loading: () =>
              const Center(child: CupertinoActivityIndicator()),
          error: (e, _) => Center(child: Text('Erro: $e')),
          data: (status) => ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              if (Platform.isAndroid) ...[
                _PermissaoCard(
                  icon: CupertinoIcons.alarm,
                  titulo: 'Alarme exato',
                  descricao:
                      'Permite que o alarme dispare na hora exata configurada.',
                  concedida: status['alarme'],
                  onConceder: () async {
                    await Permission.scheduleExactAlarm.request();
                    ref.invalidate(permissoesStatusProvider);
                  },
                ),
                _PermissaoCard(
                  icon: CupertinoIcons.bell,
                  titulo: 'Notificações',
                  descricao:
                      'Exibe a notificação quando o alarme disparar.',
                  concedida: status['notificacao'],
                  onConceder: () async {
                    await Permission.notification.request();
                    ref.invalidate(permissoesStatusProvider);
                  },
                ),
              ],
              _PermissaoCard(
                icon: CupertinoIcons.location,
                titulo: 'Localização',
                descricao:
                    'Detecta sua cidade para aplicar feriados estaduais e municipais.',
                concedida: status['localizacao'],
                onConceder: () async {
                  await Permission.locationWhenInUse.request();
                  ref.invalidate(permissoesStatusProvider);
                },
              ),
              if (Platform.isAndroid) ...[
                _PermissaoCard(
                  icon: CupertinoIcons.battery_charging,
                  titulo: 'Otimização de bateria',
                  descricao:
                      'Impede que o sistema encerre o app em segundo plano '
                      'e cancele os alarmes.',
                  concedida: status['bateria'],
                  onConceder: () async {
                    await Permission.ignoreBatteryOptimizations
                        .request();
                    ref.invalidate(permissoesStatusProvider);
                  },
                ),
                const _CartaoOemBateria(),
              ],
              if (Platform.isIOS) const _CartaoAlarmKitFoco(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissaoCard extends StatelessWidget {
  const _PermissaoCard({
    required this.icon,
    required this.titulo,
    required this.descricao,
    required this.concedida,
    required this.onConceder,
  });

  final IconData icon;
  final String titulo;
  final String descricao;
  final bool? concedida;
  final VoidCallback onConceder;

  @override
  Widget build(BuildContext context) {
    final granted = concedida ?? false;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.tertiarySystemFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: CupertinoColors.systemOrange),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.label,
                        ),
                      ),
                    ),
                    if (concedida != null)
                      Icon(
                        granted
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.xmark_circle_fill,
                        size: 18,
                        color: granted
                            ? CupertinoColors.systemGreen
                            : CupertinoColors.systemRed,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  descricao,
                  style: const TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
                if (!granted) ...[
                  const SizedBox(height: 10),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    color: CupertinoColors.systemOrange,
                    borderRadius: BorderRadius.circular(8),
                    minimumSize: Size.zero,
                    onPressed: onConceder,
                    child: const Text(
                      'Conceder',
                      style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.white),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartaoAlarmKitFoco extends StatelessWidget {
  const _CartaoAlarmKitFoco();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.tertiarySystemFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.moon_zzz,
                  size: 16, color: CupertinoColors.systemOrange),
              SizedBox(width: 8),
              Text(
                'Alarmes e modo Silencioso / Foco',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'No iOS 26+, os alarmes usam AlarmKit e disparam mesmo com o '
            'iPhone no modo Silencioso ou com um Foco ativo — idêntico ao '
            'comportamento do app Relógio nativo.\n\n'
            'Nenhuma configuração adicional é necessária.',
            style: TextStyle(
              fontSize: 13,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _CartaoOemBateria extends StatelessWidget {
  const _CartaoOemBateria();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.tertiarySystemFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(CupertinoIcons.info_circle,
                  size: 16, color: CupertinoColors.systemOrange),
              SizedBox(width: 8),
              Text(
                'Fabricantes com restrições extras',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.label,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Xiaomi (MIUI), Samsung (One UI), Huawei e outros fabricantes '
            'possuem mecanismos próprios de economia de bateria que podem '
            'cancelar alarmes mesmo com a permissão acima concedida.\n\n'
            'Para cada fabricante, acesse Configurações → Bateria → '
            'Gerenciamento de energia → Alarme Feriados → Sem restrições '
            '(o caminho varia por dispositivo).',
            style: TextStyle(
              fontSize: 13,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            color: CupertinoColors.tertiarySystemGroupedBackground,
            borderRadius: BorderRadius.circular(8),
            minimumSize: Size.zero,
            onPressed: openAppSettings,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.arrow_up_right_square,
                    size: 14, color: CupertinoColors.systemOrange),
                SizedBox(width: 6),
                Text(
                  'Abrir configurações do app',
                  style: TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.systemOrange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
