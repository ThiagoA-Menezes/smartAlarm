import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alarme_feriados/core/relogio.dart';
import 'package:alarme_feriados/domain/models/alarme.dart';
import 'package:alarme_feriados/features/configuracoes/configuracoes_providers.dart';
import 'package:alarme_feriados/features/home/home_providers.dart';

class AlarmeCriarEditarPage extends ConsumerStatefulWidget {
  const AlarmeCriarEditarPage({super.key, this.alarme});
  final Alarme? alarme;

  @override
  ConsumerState<AlarmeCriarEditarPage> createState() =>
      _AlarmeCriarEditarPageState();
}

class _AlarmeCriarEditarPageState
    extends ConsumerState<AlarmeCriarEditarPage> {
  late final TextEditingController _tituloCtrl;
  late String _hora;
  late int _diasDaSemana;
  late bool _ativo;

  static const _nomesDias = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
  static const _nomesDiasLong = [
    'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'
  ];

  @override
  void initState() {
    super.initState();
    final a = widget.alarme;
    _tituloCtrl = TextEditingController(text: a?.titulo ?? '');
    _hora = a?.hora ?? '07:00';
    _diasDaSemana = a?.diasDaSemana ?? 0x1F;
    _ativo = a?.ativo ?? true;
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    super.dispose();
  }

  bool get _editando => widget.alarme != null;

  Future<void> _escolherHora() async {
    final partes = _hora.split(':');
    final h = int.tryParse(partes[0]) ?? 7;
    final m = partes.length > 1 ? (int.tryParse(partes[1]) ?? 0) : 0;
    final initial = DateTime(2000, 1, 1, h, m);
    var selected = initial;
    final use24h = ref.read(clockFormatProvider);

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (ctx) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(ctx),
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
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    setState(() {
                      _hora =
                          '${selected.hour.toString().padLeft(2, '0')}:${selected.minute.toString().padLeft(2, '0')}';
                    });
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: initial,
                use24hFormat: use24h,
                onDateTimeChanged: (dt) => selected = dt,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDia(int bit) =>
      setState(() => _diasDaSemana ^= (1 << bit));

  Future<void> _salvar() async {
    if (_diasDaSemana == 0) {
      showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Atenção'),
          content: const Text('Selecione ao menos um dia.'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    final novo = Alarme(
      id: widget.alarme?.id,
      hora: _hora,
      diasDaSemana: _diasDaSemana,
      ativo: _ativo,
      titulo: _tituloCtrl.text.trim(),
    );
    final notifier = ref.read(alarmesProvider.notifier);
    if (_editando) {
      await notifier.atualizar(novo);
    } else {
      await notifier.criar(novo);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _confirmarDelete() async {
    showCupertinoDialog<void>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Excluir alarme?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(ctx);
              await ref
                  .read(alarmesProvider.notifier)
                  .deletar(widget.alarme!.id!);
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final use24h = ref.watch(clockFormatProvider);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_editando ? 'Editar alarme' : 'Novo alarme'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_editando)
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _confirmarDelete,
                child: const Icon(
                  CupertinoIcons.delete,
                  color: CupertinoColors.destructiveRed,
                  size: 22,
                ),
              ),
            CupertinoButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: _salvar,
              child: const Text(
                'Salvar',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _escolherHora,
              child: Center(
                child: Text(
                  formatarHora(_hora, use24h: use24h),
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w200,
                    color: CupertinoColors.label,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 7; i++)
                  _DiaBotao(
                    label: _nomesDiasLong[i],
                    letra: _nomesDias[i],
                    selecionado: _diasDaSemana & (1 << i) != 0,
                    onTap: () => _toggleDia(i),
                  ),
              ],
            ),
            const SizedBox(height: 28),
            CupertinoTextField(
              controller: _tituloCtrl,
              placeholder: 'Título (opcional)',
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 12),
              maxLength: 50,
              clearButtonMode: OverlayVisibilityMode.editing,
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            _CupertinoSwitchRow(
              label: 'Ativo',
              value: _ativo,
              onChanged: (v) => setState(() => _ativo = v),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _DiaBotao extends StatelessWidget {
  const _DiaBotao({
    required this.label,
    required this.letra,
    required this.selecionado,
    required this.onTap,
  });

  final String label;
  final String letra;
  final bool selecionado;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selecionado
                ? CupertinoColors.systemOrange
                : CupertinoColors.tertiarySystemFill,
          ),
          alignment: Alignment.center,
          child: Text(
            letra,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selecionado
                  ? CupertinoColors.white
                  : CupertinoColors.label,
            ),
          ),
        ),
      ),
    );
  }
}

class _CupertinoSwitchRow extends StatelessWidget {
  const _CupertinoSwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.tertiarySystemFill,
        borderRadius: BorderRadius.circular(10),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: CupertinoColors.label, fontSize: 16)),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
