import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:alarme_feriados/data/db/app_database.dart';
import 'package:alarme_feriados/data/db/database_provider.dart';
import 'package:alarme_feriados/domain/models/alarme.dart';
import 'package:alarme_feriados/features/alarme_criar_editar/alarme_criar_editar_page.dart';
import 'package:alarme_feriados/features/configuracoes/configuracoes_providers.dart';

Future<Widget> _wrap(AppDatabase db, {Alarme? alarme}) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWith((ref) => db),
      sharedPrefsProvider.overrideWithValue(prefs),
    ],
    child: CupertinoApp(home: AlarmeCriarEditarPage(alarme: alarme)),
  );
}

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('exibe título "Novo alarme" ao criar', (tester) async {
    await tester.pumpWidget(await _wrap(db));
    expect(find.text('Novo alarme'), findsOneWidget);
  });

  testWidgets('exibe título "Editar alarme" ao editar', (tester) async {
    const alarme = Alarme(id: 1, hora: '09:00', diasDaSemana: 0x7F);
    await tester.pumpWidget(await _wrap(db, alarme: alarme));
    expect(find.text('Editar alarme'), findsOneWidget);
  });

  testWidgets('botão excluir aparece apenas no modo edição', (tester) async {
    await tester.pumpWidget(await _wrap(db));
    expect(find.byIcon(CupertinoIcons.delete), findsNothing);

    const alarme = Alarme(id: 1, hora: '09:00', diasDaSemana: 0x7F);
    await tester.pumpWidget(await _wrap(db, alarme: alarme));
    expect(find.byIcon(CupertinoIcons.delete), findsOneWidget);
  });

  testWidgets('alerta ao salvar sem dias selecionados', (tester) async {
    await tester.pumpWidget(await _wrap(db));
    // Desmarca todos (padrão 0x1F = Seg–Sex, 5 dias selecionados)
    for (final label in ['Seg', 'Ter', 'Qua', 'Qui', 'Sex']) {
      await tester.tap(find.bySemanticsLabel(label));
      await tester.pump();
    }
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Selecione ao menos um dia.'), findsOneWidget);
  });
}
