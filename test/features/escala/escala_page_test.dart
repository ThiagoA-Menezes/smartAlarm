import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alarme_feriados/data/db/app_database.dart';
import 'package:alarme_feriados/data/db/database_provider.dart';
import 'package:alarme_feriados/features/escala/escala_page.dart';

Widget _wrap(AppDatabase db) => ProviderScope(
      overrides: [appDatabaseProvider.overrideWith((ref) => db)],
      child: const CupertinoApp(home: EscalaPage()),
    );

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  testWidgets('exibe switch de escala desativado inicialmente', (tester) async {
    await tester.pumpWidget(_wrap(db));
    await tester.pumpAndSettle();
    final sw = tester.widget<CupertinoSwitch>(find.byType(CupertinoSwitch));
    expect(sw.value, isFalse);
  });

  testWidgets('ativar switch exibe opções de preset', (tester) async {
    await tester.pumpWidget(_wrap(db));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CupertinoSwitch));
    await tester.pump();
    expect(find.text('5×2'), findsOneWidget);
    expect(find.text('12×36'), findsOneWidget);
  });

  testWidgets('salvar sem escala ativa navega de volta', (tester) async {
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
      CupertinoPageRoute<void>(builder: (_) => const EscalaPage()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);
  });
}
