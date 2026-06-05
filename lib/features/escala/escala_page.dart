import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alarme_feriados/core/datas.dart';
import 'package:alarme_feriados/domain/models/escala_usuario.dart';
import 'package:alarme_feriados/features/escala/escala_providers.dart';

class EscalaPage extends ConsumerStatefulWidget {
  const EscalaPage({super.key});

  @override
  ConsumerState<EscalaPage> createState() => _EscalaPageState();
}

class _EscalaPageState extends ConsumerState<EscalaPage> {
  static const _presets = [
    ('5×2', 5, 2),
    ('6×1', 6, 1),
    ('12×36', 1, 2),
    ('24×72', 1, 3),
  ];

  bool _ativa = false;
  String _tipoSelecionado = '5×2';
  int _diasTrabalho = 5;
  int _diasFolga = 2;
  DateTime _referencia = DateTime.now();
  bool _inicializado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_inicializado) return;
    _inicializado = true;
    ref.read(escalaProvider.future).then((escala) {
      if (!mounted) return;
      if (escala == null) return;
      setState(() {
        _ativa = true;
        _diasTrabalho = escala.diasTrabalho;
        _diasFolga = escala.diasFolga;
        _referencia =
            DateTime.tryParse(escala.dataInicioReferencia) ??
                DateTime.now();
        final match = _presets
            .where((p) =>
                p.$2 == escala.diasTrabalho &&
                p.$3 == escala.diasFolga)
            .firstOrNull;
        _tipoSelecionado = match?.$1 ?? '5×2';
      });
    });
  }

  void _selecionarPreset(String tipo) {
    final p = _presets.firstWhere((e) => e.$1 == tipo);
    setState(() {
      _tipoSelecionado = tipo;
      _diasTrabalho = p.$2;
      _diasFolga = p.$3;
    });
  }

  Future<void> _escolherReferencia() async {
    var selected = _referencia;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => Container(
        height: 300,
        color:
            CupertinoColors.systemBackground.resolveFrom(ctx),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('Cancelar'),
                  onPressed: () => Navigator.pop(ctx),
                ),
                CupertinoButton(
                  child: const Text(
                    'OK',
                    style:
                        TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() => _referencia = selected);
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _referencia,
                minimumDate: DateTime(2020),
                maximumDate: DateTime(2030),
                onDateTimeChanged: (d) => selected = d,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _salvar() async {
    final notifier = ref.read(escalaProvider.notifier);
    if (!_ativa) {
      await notifier.remover();
    } else {
      await notifier.salvar(
        EscalaUsuario(
          tipo: _tipoSelecionado,
          diasTrabalho: _diasTrabalho,
          diasFolga: _diasFolga,
          dataInicioReferencia: isoDate(_referencia),
        ),
      );
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Minha escala'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _salvar,
          child: const Text(
            'Salvar',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 8),
            _CupertinoSwitchRow(
              label: 'Usar escala de trabalho',
              subtitle:
                  'Alarmes não disparam em dias de folga do ciclo',
              value: _ativa,
              onChanged: (v) => setState(() => _ativa = v),
            ),
            if (_ativa) ...[
              const SizedBox(height: 20),
              const Text(
                'TIPO DE ESCALA',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.secondaryLabel,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              CupertinoSlidingSegmentedControl<String>(
                groupValue: _tipoSelecionado,
                children: {
                  for (final p in _presets) p.$1: Text(p.$1),
                },
                onValueChanged: (v) {
                  if (v != null) _selecionarPreset(v);
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _escolherReferencia,
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
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data de referência',
                            style: TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.label),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Primeiro dia de trabalho: ${isoDate(_referencia)}',
                            style: const TextStyle(
                              fontSize: 13,
                              color:
                                  CupertinoColors.secondaryLabel,
                            ),
                          ),
                        ],
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
              Text(
                'Ciclo: $_diasTrabalho dia(s) trabalhando, $_diasFolga dia(s) de folga',
                style: const TextStyle(
                  fontSize: 13,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _CupertinoSwitchRow extends StatelessWidget {
  const _CupertinoSwitchRow({
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.tertiarySystemFill,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.label,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                ],
              ],
            ),
          ),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
