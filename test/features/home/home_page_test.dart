import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:alarme_feriados/data/db/app_database.dart';
import 'package:alarme_feriados/data/db/database_provider.dart';
import 'package:alarme_feriados/domain/models/alarme.dart';
import 'package:alarme_feriados/features/configuracoes/configuracoes_providers.dart';
import 'package:alarme_feriados/features/home/home_page.dart';

Future<Widget> _wrap(AppDatabase db) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWith((ref) => db),
      sharedPrefsProvider.overrideWithValue(prefs),
    ],
    child: const CupertinoApp(home: HomePage()),
  );
}

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('exibe mensagem quando lista vazia', (tester) async {
    await tester.pumpWidget(await _wrap(db));
    await tester.pumpAndSettle();
    expect(find.text('Nenhum alarme cadastrado.'), findsOneWidget);
  });

  testWidgets('exibe alarme cadastrado no banco', (tester) async {
    await db.alarmeDao.inserir(const Alarme(hora: '08:00', diasDaSemana: 0x1F));
    await tester.pumpWidget(await _wrap(db));
    await tester.pumpAndSettle();
    expect(find.text('08:00'), findsOneWidget);
  });

  testWidgets('botão + navega para tela de criação', (tester) async {
    await tester.pumpWidget(await _wrap(db));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(CupertinoIcons.add));
    await tester.pumpAndSettle();
    expect(find.text('Novo alarme'), findsOneWidget);
  });
}
