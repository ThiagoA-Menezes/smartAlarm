// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarme_dao.dart';

// ignore_for_file: type=lint
mixin _$AlarmeDaoMixin on DatabaseAccessor<AppDatabase> {
  $AlarmesTable get alarmes => attachedDatabase.alarmes;
  AlarmeDaoManager get managers => AlarmeDaoManager(this);
}

class AlarmeDaoManager {
  final _$AlarmeDaoMixin _db;
  AlarmeDaoManager(this._db);
  $$AlarmesTableTableManager get alarmes =>
      $$AlarmesTableTableManager(_db.attachedDatabase, _db.alarmes);
}
