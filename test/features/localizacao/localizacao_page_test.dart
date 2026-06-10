import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alarme_feriados/data/db/app_database.dart';
import 'package:alarme_feriados/data/db/database_provider.dart';
import 'package:alarme_feriados/features/localizacao/localizacao_page.dart';

Widget _wrap(AppDatabase db) => ProviderScope(
      overrides: [appDatabaseProvider.overrideWith((ref) => db)],
      child: const CupertinoApp(home: LocalizacaoPage()),
    );

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('exibe campos cidade, estado e código IBGE', (tester) async {
    await tester.pumpWidget(_wrap(db));
    await tester.pumpAndSettle();
    expect(find.text('Cidade'), findsOneWidget);
    expect(find.text('Estado (UF)'), findsOneWidget);
    expect(find.text('Código IBGE (opcional)'), findsOneWidget);
    expect(find.byType(CupertinoTextField), findsNWidgets(3));
  });

  testWidgets('alerta ao salvar sem cidade/estado', (tester) async {
    await tester.pumpWidget(_wrap(db));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Preencha cidade e estado.'), findsOneWidget);
  });

  testWidgets('salvar com cidade e estado persiste e navega de volta',
      (tester) async {
    final nav = GlobalKey<NavigatorState>();
    await tester.pumpWidget(ProviderScope(
      overrides: [appDatabaseProvider.overrideWith((ref) => db)],
      child: CupertinoApp(
        navigatorKey: nav,
        home: const CupertinoPageScaffold(
          child: Center(child: Text('home')),
        ),
      ),
    ));
    nav.currentState!.push(
      CupertinoPageRoute<void>(builder: (_) => const LocalizacaoPage()),
    );
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(CupertinoTextField).at(0), 'Campinas');
    await tester.enterText(find.byType(CupertinoTextField).at(1), 'SP');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('home'), findsOneWidget);
    final locs = await db.localizacaoDao.buscarTodos();
    expect(locs.first.cidade, equals('Campinas'));
    expect(locs.first.estado, equals('SP'));
  });
}
