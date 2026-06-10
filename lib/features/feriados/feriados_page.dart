import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alarme_feriados/core/datas.dart';
import 'package:alarme_feriados/domain/models/feriado_cache.dart';
import 'package:alarme_feriados/features/feriados/feriados_providers.dart';
import 'package:alarme_feriados/features/localizacao/localizacao_providers.dart';

class FeriadosPage extends ConsumerWidget {
  const FeriadosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ano = DateTime.now().year;
    final state = ref.watch(feriadosProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Feriados $ano'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () =>
                  ref.read(feriadosProvider.notifier).sincronizar(),
              child: const Icon(CupertinoIcons.arrow_clockwise),
            ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 4),
              onPressed: () => _mostrarFormulario(context, ref),
              child: const Icon(CupertinoIcons.add),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: state.when(
          loading: () =>
              const Center(child: CupertinoActivityIndicator()),
          error: (e, _) => Center(child: Text('Erro: $e')),
          data: (feriados) {
            if (feriados.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum feriado. Toque em ↻ para buscar.',
                  style: TextStyle(
                      color: CupertinoColors.secondaryLabel),
                ),
              );
            }
            final nacionais = feriados
                .where((f) => f.tipo != 'municipal')
                .toList()
              ..sort((a, b) => a.data.compareTo(b.data));
            final municipais = feriados
                .where((f) => f.tipo == 'municipal')
                .toList()
              ..sort((a, b) => a.data.compareTo(b.data));

            return ListView(
              children: [
                if (nacionais.isNotEmpty) ...[
                  const _Cabecalho(label: 'Nacional / Estadual'),
                  ...nacionais.map((f) => _FeriadoTile(feriado: f)),
                ],
                if (municipais.isNotEmpty) ...[
                  const _Cabecalho(label: 'Municipal (manual)'),
                  ...municipais.map(
                    (f) => _FeriadoTile(feriado: f, deletavel: true),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _mostrarFormulario(
      BuildContext context, WidgetRef ref) async {
    final hoje = DateTime.now();
    var dataSelecionada = hoje;
    final nomeCtrl = TextEditingController();

    final locState = ref.read(localizacaoProvider);
    final ibgeAutoFill = locState.valueOrNull?.codigoIBGE ?? '0';
    final ibgeCtrl = TextEditingController(
      text: ibgeAutoFill == '0' ? '' : ibgeAutoFill,
    );

    bool salvar = false;

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          height: 480,
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(ctx).bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(ctx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                    const Text(
                      'Feriado municipal',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: CupertinoColors.label,
                      ),
                    ),
                    CupertinoButton(
                      child: const Text(
                        'Salvar',
                        style:
                            TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        salvar = true;
                        Navigator.pop(ctx);
                      },
                    ),
                  ],
                ),
              ),
              Container(height: 0.5, color: CupertinoColors.separator),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await showCupertinoModalPopup<void>(
                          context: ctx,
                          builder: (c2) => Container(
                            height: 260,
                            color: CupertinoColors.systemBackground
                                .resolveFrom(c2),
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: dataSelecionada,
                              minimumDate: DateTime(hoje.year),
                              maximumDate: DateTime(hoje.year + 1),
                              onDateTimeChanged: (d) =>
                                  setModalState(
                                      () => dataSelecionada = d),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.tertiarySystemFill,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isoDate(dataSelecionada),
                              style: const TextStyle(
                                  color: CupertinoColors.label,
                                  fontSize: 16),
                            ),
                            const Icon(
                              CupertinoIcons.calendar,
                              color: CupertinoColors.secondaryLabel,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: nomeCtrl,
                      placeholder: 'Nome do feriado',
                      autofocus: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.tertiarySystemFill,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CupertinoTextField(
                      controller: ibgeCtrl,
                      placeholder: 'Código IBGE (7 dígitos)',
                      keyboardType: TextInputType.number,
                      maxLength: 7,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.tertiarySystemFill,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final nome = nomeCtrl.text.trim();
    final ibge = ibgeCtrl.text.trim();
    nomeCtrl.dispose();
    ibgeCtrl.dispose();

    if (!salvar || nome.isEmpty) return;

    await ref.read(feriadosProvider.notifier).inserirManual(
          FeriadoCache(
            data: isoDate(dataSelecionada),
            nome: nome,
            tipo: 'municipal',
            codigoIBGE: ibge.isEmpty ? '0' : ibge,
            ano: dataSelecionada.year,
          ),
        );
  }
}

class _Cabecalho extends StatelessWidget {
  const _Cabecalho({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
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

class _FeriadoTile extends ConsumerWidget {
  const _FeriadoTile({required this.feriado, this.deletavel = false});
  final FeriadoCache feriado;
  final bool deletavel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoje = isoDate(DateTime.now());
    final isHoje = feriado.data == hoje;

    Widget tile = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isHoje
                  ? CupertinoColors.systemOrange
                  : CupertinoColors.tertiarySystemFill,
            ),
            alignment: Alignment.center,
            child: Text(
              _dia(feriado.data),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isHoje
                    ? CupertinoColors.white
                    : CupertinoColors.label,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feriado.nome,
                  style: const TextStyle(
                      fontSize: 16, color: CupertinoColors.label),
                ),
                Text(
                  _mesAbrev(feriado.data),
                  style: const TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ],
            ),
          ),
          if (isHoje)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: CupertinoColors.systemOrange.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Hoje',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );

    if (!deletavel) return tile;

    return Dismissible(
      key: ValueKey(feriado.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: CupertinoColors.destructiveRed,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child:
            const Icon(CupertinoIcons.delete, color: CupertinoColors.white),
      ),
      onDismissed: (_) =>
          ref.read(feriadosProvider.notifier).deletar(feriado.id!),
      child: tile,
    );
  }

  String _dia(String iso) =>
      iso.length >= 10 ? iso.substring(8, 10) : '?';

  String _mesAbrev(String iso) {
    const meses = [
      'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
      'jul', 'ago', 'set', 'out', 'nov', 'dez',
    ];
    if (iso.length < 10) return iso;
    final mes = (int.tryParse(iso.substring(5, 7)) ?? 1) - 1;
    final mesIdx = mes.clamp(0, 11);
    return '${iso.substring(0, 4)} · ${meses[mesIdx]}';
  }
}
