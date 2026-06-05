import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alarme_feriados/domain/models/localizacao.dart';
import 'package:alarme_feriados/features/localizacao/localizacao_providers.dart';
import 'package:alarme_feriados/services/localizacao_service.dart';

class LocalizacaoPage extends ConsumerStatefulWidget {
  const LocalizacaoPage({super.key});

  @override
  ConsumerState<LocalizacaoPage> createState() =>
      _LocalizacaoPageState();
}

class _LocalizacaoPageState extends ConsumerState<LocalizacaoPage> {
  late final TextEditingController _cidadeCtrl;
  late final TextEditingController _estadoCtrl;
  late final TextEditingController _ibgeCtrl;
  bool _detectando = false;
  bool _inicializado = false;

  @override
  void initState() {
    super.initState();
    _cidadeCtrl = TextEditingController();
    _estadoCtrl = TextEditingController();
    _ibgeCtrl = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_inicializado) return;
    _inicializado = true;
    ref.read(localizacaoProvider.future).then((loc) {
      if (!mounted || loc == null) return;
      _cidadeCtrl.text = loc.cidade;
      _estadoCtrl.text = loc.estado;
      _ibgeCtrl.text = loc.codigoIBGE == '0' ? '' : loc.codigoIBGE;
    });
  }

  @override
  void dispose() {
    _cidadeCtrl.dispose();
    _estadoCtrl.dispose();
    _ibgeCtrl.dispose();
    super.dispose();
  }

  Future<void> _detectar() async {
    setState(() => _detectando = true);
    try {
      final loc = await LocalizacaoService.detectar();
      if (!mounted) return;
      if (loc == null) {
        showCupertinoDialog<void>(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Localização'),
            content: const Text(
                'Não foi possível detectar a localização.'),
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
      _cidadeCtrl.text = loc.cidade;
      _estadoCtrl.text = loc.estado;
      _ibgeCtrl.text = '';
    } finally {
      if (mounted) setState(() => _detectando = false);
    }
  }

  Future<void> _salvar() async {
    final cidade = _cidadeCtrl.text.trim();
    final estado = _estadoCtrl.text.trim().toUpperCase();
    if (cidade.isEmpty || estado.isEmpty) {
      showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Campos obrigatórios'),
          content: const Text('Preencha cidade e estado.'),
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
    final ibge = _ibgeCtrl.text.trim();
    await ref.read(localizacaoProvider.notifier).salvar(
          Localizacao(
            cidade: cidade,
            estado: estado,
            codigoIBGE: ibge.isEmpty ? '0' : ibge,
          ),
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Localização'),
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
            CupertinoButton.filled(
              onPressed: _detectando ? null : _detectar,
              child: _detectando
                  ? const CupertinoActivityIndicator(
                      color: CupertinoColors.white)
                  : const Text('Detectar automaticamente'),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            _Campo(
              label: 'Cidade',
              controller: _cidadeCtrl,
              placeholder: 'Ex: São Paulo',
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            _Campo(
              label: 'Estado (UF)',
              controller: _estadoCtrl,
              placeholder: 'Ex: SP',
              maxLength: 2,
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            _Campo(
              label: 'Código IBGE (opcional)',
              controller: _ibgeCtrl,
              placeholder: '7 dígitos – para feriados municipais',
              keyboardType: TextInputType.number,
              maxLength: 7,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _Campo extends StatelessWidget {
  const _Campo({
    required this.label,
    required this.controller,
    required this.placeholder,
    this.maxLength,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController controller;
  final String placeholder;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: CupertinoColors.secondaryLabel,
            ),
          ),
        ),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          maxLength: maxLength,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          clearButtonMode: OverlayVisibilityMode.editing,
          decoration: BoxDecoration(
            color: CupertinoColors.tertiarySystemFill,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
