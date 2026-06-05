// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localizacao_dao.dart';

// ignore_for_file: type=lint
mixin _$LocalizacaoDaoMixin on DatabaseAccessor<AppDatabase> {
  $LocalizacoesTable get localizacoes => attachedDatabase.localizacoes;
  LocalizacaoDaoManager get managers => LocalizacaoDaoManager(this);
}

class LocalizacaoDaoManager {
  final _$LocalizacaoDaoMixin _db;
  LocalizacaoDaoManager(this._db);
  $$LocalizacoesTableTableManager get localizacoes =>
      $$LocalizacoesTableTableManager(_db.attachedDatabase, _db.localizacoes);
}
