import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alarme_feriados/features/permissoes/permissoes_page.dart';

Widget _wrap(Map<String, bool> status) => ProviderScope(
      overrides: [
        permissoesStatusProvider.overrideWith((ref) async => status),
      ],
      child: const CupertinoApp(home: PermissoesPage()),
    );

void main() {
  // No host de testes (Linux) Platform.isAndroid/isIOS são false, então
  // apenas o card de localização é exibido.
  testWidgets('exibe barra de navegação com título', (tester) async {
    await tester.pumpWidget(_wrap({}));
    await tester.pumpAndSettle();
    expect(find.text('Permissões e bateria'), findsOneWidget);
  });

  testWidgets('ícone verde quando permissão concedida', (tester) async {
    await tester.pumpWidget(_wrap({'localizacao': true}));
    await tester.pumpAndSettle();
    expect(find.byIcon(CupertinoIcons.checkmark_circle_fill), findsWidgets);
    expect(find.byIcon(CupertinoIcons.xmark_circle_fill), findsNothing);
    expect(find.text('Conceder'), findsNothing);
  });

  testWidgets('ícone vermelho e botão "Conceder" quando permissão negada',
      (tester) async {
    await tester.pumpWidget(_wrap({'localizacao': false}));
    await tester.pumpAndSettle();
    expect(find.byIcon(CupertinoIcons.xmark_circle_fill), findsWidgets);
    expect(find.text('Conceder'), findsWidgets);
  });

  testWidgets('card de localização sempre visível', (tester) async {
    await tester.pumpWidget(_wrap({}));
    await tester.pumpAndSettle();
    expect(find.text('Localização'), findsOneWidget);
  });
}
