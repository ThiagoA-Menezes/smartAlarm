import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alarme_feriados/features/configuracoes/configuracoes_providers.dart';
import 'package:alarme_feriados/features/permissoes/permissoes_page.dart';

class ConfiguracoesPage extends ConsumerWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final use24h = ref.watch(clockFormatProvider);

    return CupertinoPageScaffold(
      navigationBar:
          const CupertinoNavigationBar(middle: Text('Configurações')),
      child: SafeArea(
        top: false,
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const _SectionHeader(label: 'Exibição'),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  title: const Text('Formato 24 horas'),
                  subtitle: Text(
                      use24h ? 'Ex: 07:00 · 13:30' : 'Ex: 7:00 AM · 1:30 PM'),
                  trailing: CupertinoSwitch(
                    value: use24h,
                    onChanged: (_) =>
                        ref.read(clockFormatProvider.notifier).toggle(),
                  ),
                ),
              ],
            ),
            const _SectionHeader(label: 'Sistema'),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: const Icon(
                    CupertinoIcons.shield_lefthalf_fill,
                    color: CupertinoColors.systemGreen,
                  ),
                  title: const Text('Permissões e bateria'),
                  subtitle: const Text(
                    'Alarme exato, notificações e bateria',
                  ),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute<void>(
                      builder: (_) => const PermissoesPage(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.secondaryLabel,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
