// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feriado_cache_dao.dart';

// ignore_for_file: type=lint
mixin _$FeriadoCacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $FeriadosCacheTable get feriadosCache => attachedDatabase.feriadosCache;
  FeriadoCacheDaoManager get managers => FeriadoCacheDaoManager(this);
}

class FeriadoCacheDaoManager {
  final _$FeriadoCacheDaoMixin _db;
  FeriadoCacheDaoManager(this._db);
  $$FeriadosCacheTableTableManager get feriadosCache =>
      $$FeriadosCacheTableTableManager(_db.attachedDatabase, _db.feriadosCache);
}
