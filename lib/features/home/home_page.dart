import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alarme_feriados/core/relogio.dart';
import 'package:alarme_feriados/domain/models/alarme.dart';
import 'package:alarme_feriados/features/alarme_criar_editar/alarme_criar_editar_page.dart';
import 'package:alarme_feriados/features/configuracoes/configuracoes_page.dart';
import 'package:alarme_feriados/features/configuracoes/configuracoes_providers.dart';
import 'package:alarme_feriados/features/escala/escala_page.dart';
import 'package:alarme_feriados/features/feriados/feriados_page.dart';
import 'package:alarme_feriados/features/home/home_providers.dart';
import 'package:alarme_feriados/features/localizacao/localizacao_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _mostrarMenu(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                CupertinoPageRoute<void>(builder: (_) => const FeriadosPage()),
              );
            },
            child: const Text('Feriados'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                CupertinoPageRoute<void>(builder: (_) => const EscalaPage()),
              );
            },
            child: const Text('Minha escala'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                CupertinoPageRoute<void>(
                    builder: (_) => const LocalizacaoPage()),
              );
            },
            child: const Text('Localização'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                CupertinoPageRoute<void>(
                    builder: (_) => const ConfiguracoesPage()),
              );
            },
            child: const Text('Configurações'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx),
          isDefaultAction: true,
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(alarmesProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Alarmes'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _mostrarMenu(context),
              child: const Icon(CupertinoIcons.ellipsis_circle),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute<void>(
                  builder: (_) => const AlarmeCriarEditarPage(),
                ),
              ),
              child: const Icon(CupertinoIcons.add),
            ),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: state.when(
          loading: () =>
              const Center(child: CupertinoActivityIndicator()),
          error: (e, _) => Center(child: Text('Erro: $e')),
          data: (alarmes) => alarmes.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum alarme cadastrado.',
                    style: TextStyle(
                        color: CupertinoColors.secondaryLabel),
                  ),
                )
              : ListView.separated(
                  itemCount: alarmes.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 0,
                    indent: 16,
                  ),
                  itemBuilder: (_, i) =>
                      _AlarmeTile(alarme: alarmes[i]),
                ),
        ),
      ),
    );
  }
}

class _AlarmeTile extends ConsumerWidget {
  const _AlarmeTile({required this.alarme});
  final Alarme alarme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(alarmesProvider.notifier);
    final use24h = ref.watch(clockFormatProvider);

    return Dismissible(
      key: ValueKey(alarme.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: CupertinoColors.destructiveRed,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(CupertinoIcons.delete,
            color: CupertinoColors.white),
      ),
      onDismissed: (_) => notifier.deletar(alarme.id!),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute<void>(
            builder: (_) => AlarmeCriarEditarPage(alarme: alarme),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatarHora(alarme.hora, use24h: use24h),
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w200,
                        height: 1.1,
                        color: alarme.ativo
                            ? CupertinoColors.label
                            : CupertinoColors.secondaryLabel,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      alarme.titulo.isEmpty
                          ? _descDias(alarme.diasDaSemana)
                          : '${alarme.titulo} · ${_descDias(alarme.diasDaSemana)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: alarme.ativo
                            ? CupertinoColors.secondaryLabel
                            : CupertinoColors.tertiaryLabel,
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoSwitch(
                value: alarme.ativo,
                onChanged: (_) => notifier.toggleAtivo(alarme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _descDias(int mask) {
    if (mask == 0x7F) return 'Todos os dias';
    if (mask == 0x1F) return 'Dias úteis';
    if (mask == 0x60) return 'Fim de semana';
    const nomes = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    return [
      for (var i = 0; i < 7; i++)
        if (mask & (1 << i) != 0) nomes[i],
    ].join(', ');
  }
}
