// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AlarmesTable extends Alarmes with TableInfo<$AlarmesTable, AlarmeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _horaMeta = const VerificationMeta('hora');
  @override
  late final GeneratedColumn<String> hora = GeneratedColumn<String>(
      'hora', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _diasDaSemanaMeta =
      const VerificationMeta('diasDaSemana');
  @override
  late final GeneratedColumn<int> diasDaSemana = GeneratedColumn<int>(
      'dias_da_semana', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ativoMeta = const VerificationMeta('ativo');
  @override
  late final GeneratedColumn<bool> ativo = GeneratedColumn<bool>(
      'ativo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("ativo" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
      'titulo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns => [id, hora, diasDaSemana, ativo, titulo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarmes';
  @override
  VerificationContext validateIntegrity(Insertable<AlarmeRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hora')) {
      context.handle(
          _horaMeta, hora.isAcceptableOrUnknown(data['hora']!, _horaMeta));
    } else if (isInserting) {
      context.missing(_horaMeta);
    }
    if (data.containsKey('dias_da_semana')) {
      context.handle(
          _diasDaSemanaMeta,
          diasDaSemana.isAcceptableOrUnknown(
              data['dias_da_semana']!, _diasDaSemanaMeta));
    } else if (isInserting) {
      context.missing(_diasDaSemanaMeta);
    }
    if (data.containsKey('ativo')) {
      context.handle(
          _ativoMeta, ativo.isAcceptableOrUnknown(data['ativo']!, _ativoMeta));
    }
    if (data.containsKey('titulo')) {
      context.handle(_tituloMeta,
          titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlarmeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlarmeRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      hora: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hora'])!,
      diasDaSemana: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dias_da_semana'])!,
      ativo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ativo'])!,
      titulo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}titulo'])!,
    );
  }

  @override
  $AlarmesTable createAlias(String alias) {
    return $AlarmesTable(attachedDatabase, alias);
  }
}

class AlarmeRow extends DataClass implements Insertable<AlarmeRow> {
  final int id;
  final String hora;
  final int diasDaSemana;
  final bool ativo;
  final String titulo;
  const AlarmeRow(
      {required this.id,
      required this.hora,
      required this.diasDaSemana,
      required this.ativo,
      required this.titulo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hora'] = Variable<String>(hora);
    map['dias_da_semana'] = Variable<int>(diasDaSemana);
    map['ativo'] = Variable<bool>(ativo);
    map['titulo'] = Variable<String>(titulo);
    return map;
  }

  AlarmesCompanion toCompanion(bool nullToAbsent) {
    return AlarmesCompanion(
      id: Value(id),
      hora: Value(hora),
      diasDaSemana: Value(diasDaSemana),
      ativo: Value(ativo),
      titulo: Value(titulo),
    );
  }

  factory AlarmeRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlarmeRow(
      id: serializer.fromJson<int>(json['id']),
      hora: serializer.fromJson<String>(json['hora']),
      diasDaSemana: serializer.fromJson<int>(json['diasDaSemana']),
      ativo: serializer.fromJson<bool>(json['ativo']),
      titulo: serializer.fromJson<String>(json['titulo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hora': serializer.toJson<String>(hora),
      'diasDaSemana': serializer.toJson<int>(diasDaSemana),
      'ativo': serializer.toJson<bool>(ativo),
      'titulo': serializer.toJson<String>(titulo),
    };
  }

  AlarmeRow copyWith(
          {int? id,
          String? hora,
          int? diasDaSemana,
          bool? ativo,
          String? titulo}) =>
      AlarmeRow(
        id: id ?? this.id,
        hora: hora ?? this.hora,
        diasDaSemana: diasDaSemana ?? this.diasDaSemana,
        ativo: ativo ?? this.ativo,
        titulo: titulo ?? this.titulo,
      );
  AlarmeRow copyWithCompanion(AlarmesCompanion data) {
    return AlarmeRow(
      id: data.id.present ? data.id.value : this.id,
      hora: data.hora.present ? data.hora.value : this.hora,
      diasDaSemana: data.diasDaSemana.present
          ? data.diasDaSemana.value
          : this.diasDaSemana,
      ativo: data.ativo.present ? data.ativo.value : this.ativo,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlarmeRow(')
          ..write('id: $id, ')
          ..write('hora: $hora, ')
          ..write('diasDaSemana: $diasDaSemana, ')
          ..write('ativo: $ativo, ')
          ..write('titulo: $titulo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hora, diasDaSemana, ativo, titulo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlarmeRow &&
          other.id == this.id &&
          other.hora == this.hora &&
          other.diasDaSemana == this.diasDaSemana &&
          other.ativo == this.ativo &&
          other.titulo == this.titulo);
}

class AlarmesCompanion extends UpdateCompanion<AlarmeRow> {
  final Value<int> id;
  final Value<String> hora;
  final Value<int> diasDaSemana;
  final Value<bool> ativo;
  final Value<String> titulo;
  const AlarmesCompanion({
    this.id = const Value.absent(),
    this.hora = const Value.absent(),
    this.diasDaSemana = const Value.absent(),
    this.ativo = const Value.absent(),
    this.titulo = const Value.absent(),
  });
  AlarmesCompanion.insert({
    this.id = const Value.absent(),
    required String hora,
    required int diasDaSemana,
    this.ativo = const Value.absent(),
    this.titulo = const Value.absent(),
  })  : hora = Value(hora),
        diasDaSemana = Value(diasDaSemana);
  static Insertable<AlarmeRow> custom({
    Expression<int>? id,
    Expression<String>? hora,
    Expression<int>? diasDaSemana,
    Expression<bool>? ativo,
    Expression<String>? titulo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hora != null) 'hora': hora,
      if (diasDaSemana != null) 'dias_da_semana': diasDaSemana,
      if (ativo != null) 'ativo': ativo,
      if (titulo != null) 'titulo': titulo,
    });
  }

  AlarmesCompanion copyWith(
      {Value<int>? id,
      Value<String>? hora,
      Value<int>? diasDaSemana,
      Value<bool>? ativo,
      Value<String>? titulo}) {
    return AlarmesCompanion(
      id: id ?? this.id,
      hora: hora ?? this.hora,
      diasDaSemana: diasDaSemana ?? this.diasDaSemana,
      ativo: ativo ?? this.ativo,
      titulo: titulo ?? this.titulo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hora.present) {
      map['hora'] = Variable<String>(hora.value);
    }
    if (diasDaSemana.present) {
      map['dias_da_semana'] = Variable<int>(diasDaSemana.value);
    }
    if (ativo.present) {
      map['ativo'] = Variable<bool>(ativo.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmesCompanion(')
          ..write('id: $id, ')
          ..write('hora: $hora, ')
          ..write('diasDaSemana: $diasDaSemana, ')
          ..write('ativo: $ativo, ')
          ..write('titulo: $titulo')
          ..write(')'))
        .toString();
  }
}

class $EscalasUsuarioTable extends EscalasUsuario
    with TableInfo<$EscalasUsuarioTable, EscalaUsuarioRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EscalasUsuarioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _diasTrabalhoMeta =
      const VerificationMeta('diasTrabalho');
  @override
  late final GeneratedColumn<int> diasTrabalho = GeneratedColumn<int>(
      'dias_trabalho', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diasFolgaMeta =
      const VerificationMeta('diasFolga');
  @override
  late final GeneratedColumn<int> diasFolga = GeneratedColumn<int>(
      'dias_folga', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dataInicioReferenciaMeta =
      const VerificationMeta('dataInicioReferencia');
  @override
  late final GeneratedColumn<String> dataInicioReferencia =
      GeneratedColumn<String>('data_inicio_referencia', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tipo, diasTrabalho, diasFolga, dataInicioReferencia];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'escalas_usuario';
  @override
  VerificationContext validateIntegrity(Insertable<EscalaUsuarioRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('dias_trabalho')) {
      context.handle(
          _diasTrabalhoMeta,
          diasTrabalho.isAcceptableOrUnknown(
              data['dias_trabalho']!, _diasTrabalhoMeta));
    } else if (isInserting) {
      context.missing(_diasTrabalhoMeta);
    }
    if (data.containsKey('dias_folga')) {
      context.handle(_diasFolgaMeta,
          diasFolga.isAcceptableOrUnknown(data['dias_folga']!, _diasFolgaMeta));
    } else if (isInserting) {
      context.missing(_diasFolgaMeta);
    }
    if (data.containsKey('data_inicio_referencia')) {
      context.handle(
          _dataInicioReferenciaMeta,
          dataInicioReferencia.isAcceptableOrUnknown(
              data['data_inicio_referencia']!, _dataInicioReferenciaMeta));
    } else if (isInserting) {
      context.missing(_dataInicioReferenciaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EscalaUsuarioRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EscalaUsuarioRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      diasTrabalho: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dias_trabalho'])!,
      diasFolga: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dias_folga'])!,
      dataInicioReferencia: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data_inicio_referencia'])!,
    );
  }

  @override
  $EscalasUsuarioTable createAlias(String alias) {
    return $EscalasUsuarioTable(attachedDatabase, alias);
  }
}

class EscalaUsuarioRow extends DataClass
    implements Insertable<EscalaUsuarioRow> {
  final int id;
  final String tipo;
  final int diasTrabalho;
  final int diasFolga;
  final String dataInicioReferencia;
  const EscalaUsuarioRow(
      {required this.id,
      required this.tipo,
      required this.diasTrabalho,
      required this.diasFolga,
      required this.dataInicioReferencia});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    map['dias_trabalho'] = Variable<int>(diasTrabalho);
    map['dias_folga'] = Variable<int>(diasFolga);
    map['data_inicio_referencia'] = Variable<String>(dataInicioReferencia);
    return map;
  }

  EscalasUsuarioCompanion toCompanion(bool nullToAbsent) {
    return EscalasUsuarioCompanion(
      id: Value(id),
      tipo: Value(tipo),
      diasTrabalho: Value(diasTrabalho),
      diasFolga: Value(diasFolga),
      dataInicioReferencia: Value(dataInicioReferencia),
    );
  }

  factory EscalaUsuarioRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EscalaUsuarioRow(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      diasTrabalho: serializer.fromJson<int>(json['diasTrabalho']),
      diasFolga: serializer.fromJson<int>(json['diasFolga']),
      dataInicioReferencia:
          serializer.fromJson<String>(json['dataInicioReferencia']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'diasTrabalho': serializer.toJson<int>(diasTrabalho),
      'diasFolga': serializer.toJson<int>(diasFolga),
      'dataInicioReferencia': serializer.toJson<String>(dataInicioReferencia),
    };
  }

  EscalaUsuarioRow copyWith(
          {int? id,
          String? tipo,
          int? diasTrabalho,
          int? diasFolga,
          String? dataInicioReferencia}) =>
      EscalaUsuarioRow(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        diasTrabalho: diasTrabalho ?? this.diasTrabalho,
        diasFolga: diasFolga ?? this.diasFolga,
        dataInicioReferencia: dataInicioReferencia ?? this.dataInicioReferencia,
      );
  EscalaUsuarioRow copyWithCompanion(EscalasUsuarioCompanion data) {
    return EscalaUsuarioRow(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      diasTrabalho: data.diasTrabalho.present
          ? data.diasTrabalho.value
          : this.diasTrabalho,
      diasFolga: data.diasFolga.present ? data.diasFolga.value : this.diasFolga,
      dataInicioReferencia: data.dataInicioReferencia.present
          ? data.dataInicioReferencia.value
          : this.dataInicioReferencia,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EscalaUsuarioRow(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('diasTrabalho: $diasTrabalho, ')
          ..write('diasFolga: $diasFolga, ')
          ..write('dataInicioReferencia: $dataInicioReferencia')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tipo, diasTrabalho, diasFolga, dataInicioReferencia);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EscalaUsuarioRow &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.diasTrabalho == this.diasTrabalho &&
          other.diasFolga == this.diasFolga &&
          other.dataInicioReferencia == this.dataInicioReferencia);
}

class EscalasUsuarioCompanion extends UpdateCompanion<EscalaUsuarioRow> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<int> diasTrabalho;
  final Value<int> diasFolga;
  final Value<String> dataInicioReferencia;
  const EscalasUsuarioCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.diasTrabalho = const Value.absent(),
    this.diasFolga = const Value.absent(),
    this.dataInicioReferencia = const Value.absent(),
  });
  EscalasUsuarioCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
    required int diasTrabalho,
    required int diasFolga,
    required String dataInicioReferencia,
  })  : tipo = Value(tipo),
        diasTrabalho = Value(diasTrabalho),
        diasFolga = Value(diasFolga),
        dataInicioReferencia = Value(dataInicioReferencia);
  static Insertable<EscalaUsuarioRow> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<int>? diasTrabalho,
    Expression<int>? diasFolga,
    Expression<String>? dataInicioReferencia,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (diasTrabalho != null) 'dias_trabalho': diasTrabalho,
      if (diasFolga != null) 'dias_folga': diasFolga,
      if (dataInicioReferencia != null)
        'data_inicio_referencia': dataInicioReferencia,
    });
  }

  EscalasUsuarioCompanion copyWith(
      {Value<int>? id,
      Value<String>? tipo,
      Value<int>? diasTrabalho,
      Value<int>? diasFolga,
      Value<String>? dataInicioReferencia}) {
    return EscalasUsuarioCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      diasTrabalho: diasTrabalho ?? this.diasTrabalho,
      diasFolga: diasFolga ?? this.diasFolga,
      dataInicioReferencia: dataInicioReferencia ?? this.dataInicioReferencia,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (diasTrabalho.present) {
      map['dias_trabalho'] = Variable<int>(diasTrabalho.value);
    }
    if (diasFolga.present) {
      map['dias_folga'] = Variable<int>(diasFolga.value);
    }
    if (dataInicioReferencia.present) {
      map['data_inicio_referencia'] =
          Variable<String>(dataInicioReferencia.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EscalasUsuarioCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('diasTrabalho: $diasTrabalho, ')
          ..write('diasFolga: $diasFolga, ')
          ..write('dataInicioReferencia: $dataInicioReferencia')
          ..write(')'))
        .toString();
  }
}

class $LocalizacoesTable extends Localizacoes
    with TableInfo<$LocalizacoesTable, LocalizacaoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalizacoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cidadeMeta = const VerificationMeta('cidade');
  @override
  late final GeneratedColumn<String> cidade = GeneratedColumn<String>(
      'cidade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoIBGEMeta =
      const VerificationMeta('codigoIBGE');
  @override
  late final GeneratedColumn<String> codigoIBGE = GeneratedColumn<String>(
      'codigo_i_b_g_e', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, cidade, estado, codigoIBGE];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'localizacoes';
  @override
  VerificationContext validateIntegrity(Insertable<LocalizacaoRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cidade')) {
      context.handle(_cidadeMeta,
          cidade.isAcceptableOrUnknown(data['cidade']!, _cidadeMeta));
    } else if (isInserting) {
      context.missing(_cidadeMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('codigo_i_b_g_e')) {
      context.handle(
          _codigoIBGEMeta,
          codigoIBGE.isAcceptableOrUnknown(
              data['codigo_i_b_g_e']!, _codigoIBGEMeta));
    } else if (isInserting) {
      context.missing(_codigoIBGEMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalizacaoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalizacaoRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cidade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cidade'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      codigoIBGE: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo_i_b_g_e'])!,
    );
  }

  @override
  $LocalizacoesTable createAlias(String alias) {
    return $LocalizacoesTable(attachedDatabase, alias);
  }
}

class LocalizacaoRow extends DataClass implements Insertable<LocalizacaoRow> {
  final int id;
  final String cidade;
  final String estado;
  final String codigoIBGE;
  const LocalizacaoRow(
      {required this.id,
      required this.cidade,
      required this.estado,
      required this.codigoIBGE});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cidade'] = Variable<String>(cidade);
    map['estado'] = Variable<String>(estado);
    map['codigo_i_b_g_e'] = Variable<String>(codigoIBGE);
    return map;
  }

  LocalizacoesCompanion toCompanion(bool nullToAbsent) {
    return LocalizacoesCompanion(
      id: Value(id),
      cidade: Value(cidade),
      estado: Value(estado),
      codigoIBGE: Value(codigoIBGE),
    );
  }

  factory LocalizacaoRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalizacaoRow(
      id: serializer.fromJson<int>(json['id']),
      cidade: serializer.fromJson<String>(json['cidade']),
      estado: serializer.fromJson<String>(json['estado']),
      codigoIBGE: serializer.fromJson<String>(json['codigoIBGE']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cidade': serializer.toJson<String>(cidade),
      'estado': serializer.toJson<String>(estado),
      'codigoIBGE': serializer.toJson<String>(codigoIBGE),
    };
  }

  LocalizacaoRow copyWith(
          {int? id, String? cidade, String? estado, String? codigoIBGE}) =>
      LocalizacaoRow(
        id: id ?? this.id,
        cidade: cidade ?? this.cidade,
        estado: estado ?? this.estado,
        codigoIBGE: codigoIBGE ?? this.codigoIBGE,
      );
  LocalizacaoRow copyWithCompanion(LocalizacoesCompanion data) {
    return LocalizacaoRow(
      id: data.id.present ? data.id.value : this.id,
      cidade: data.cidade.present ? data.cidade.value : this.cidade,
      estado: data.estado.present ? data.estado.value : this.estado,
      codigoIBGE:
          data.codigoIBGE.present ? data.codigoIBGE.value : this.codigoIBGE,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalizacaoRow(')
          ..write('id: $id, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('codigoIBGE: $codigoIBGE')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cidade, estado, codigoIBGE);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalizacaoRow &&
          other.id == this.id &&
          other.cidade == this.cidade &&
          other.estado == this.estado &&
          other.codigoIBGE == this.codigoIBGE);
}

class LocalizacoesCompanion extends UpdateCompanion<LocalizacaoRow> {
  final Value<int> id;
  final Value<String> cidade;
  final Value<String> estado;
  final Value<String> codigoIBGE;
  const LocalizacoesCompanion({
    this.id = const Value.absent(),
    this.cidade = const Value.absent(),
    this.estado = const Value.absent(),
    this.codigoIBGE = const Value.absent(),
  });
  LocalizacoesCompanion.insert({
    this.id = const Value.absent(),
    required String cidade,
    required String estado,
    required String codigoIBGE,
  })  : cidade = Value(cidade),
        estado = Value(estado),
        codigoIBGE = Value(codigoIBGE);
  static Insertable<LocalizacaoRow> custom({
    Expression<int>? id,
    Expression<String>? cidade,
    Expression<String>? estado,
    Expression<String>? codigoIBGE,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cidade != null) 'cidade': cidade,
      if (estado != null) 'estado': estado,
      if (codigoIBGE != null) 'codigo_i_b_g_e': codigoIBGE,
    });
  }

  LocalizacoesCompanion copyWith(
      {Value<int>? id,
      Value<String>? cidade,
      Value<String>? estado,
      Value<String>? codigoIBGE}) {
    return LocalizacoesCompanion(
      id: id ?? this.id,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      codigoIBGE: codigoIBGE ?? this.codigoIBGE,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cidade.present) {
      map['cidade'] = Variable<String>(cidade.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (codigoIBGE.present) {
      map['codigo_i_b_g_e'] = Variable<String>(codigoIBGE.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalizacoesCompanion(')
          ..write('id: $id, ')
          ..write('cidade: $cidade, ')
          ..write('estado: $estado, ')
          ..write('codigoIBGE: $codigoIBGE')
          ..write(')'))
        .toString();
  }
}

class $FeriadosCacheTable extends FeriadosCache
    with TableInfo<$FeriadosCacheTable, FeriadoCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeriadosCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoIBGEMeta =
      const VerificationMeta('codigoIBGE');
  @override
  late final GeneratedColumn<String> codigoIBGE = GeneratedColumn<String>(
      'codigo_i_b_g_e', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _anoMeta = const VerificationMeta('ano');
  @override
  late final GeneratedColumn<int> ano = GeneratedColumn<int>(
      'ano', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, data, nome, tipo, codigoIBGE, ano];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feriados_cache';
  @override
  VerificationContext validateIntegrity(Insertable<FeriadoCacheRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('codigo_i_b_g_e')) {
      context.handle(
          _codigoIBGEMeta,
          codigoIBGE.isAcceptableOrUnknown(
              data['codigo_i_b_g_e']!, _codigoIBGEMeta));
    } else if (isInserting) {
      context.missing(_codigoIBGEMeta);
    }
    if (data.containsKey('ano')) {
      context.handle(
          _anoMeta, ano.isAcceptableOrUnknown(data['ano']!, _anoMeta));
    } else if (isInserting) {
      context.missing(_anoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeriadoCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeriadoCacheRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      codigoIBGE: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo_i_b_g_e'])!,
      ano: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ano'])!,
    );
  }

  @override
  $FeriadosCacheTable createAlias(String alias) {
    return $FeriadosCacheTable(attachedDatabase, alias);
  }
}

class FeriadoCacheRow extends DataClass implements Insertable<FeriadoCacheRow> {
  final int id;
  final String data;
  final String nome;
  final String tipo;
  final String codigoIBGE;
  final int ano;
  const FeriadoCacheRow(
      {required this.id,
      required this.data,
      required this.nome,
      required this.tipo,
      required this.codigoIBGE,
      required this.ano});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['data'] = Variable<String>(data);
    map['nome'] = Variable<String>(nome);
    map['tipo'] = Variable<String>(tipo);
    map['codigo_i_b_g_e'] = Variable<String>(codigoIBGE);
    map['ano'] = Variable<int>(ano);
    return map;
  }

  FeriadosCacheCompanion toCompanion(bool nullToAbsent) {
    return FeriadosCacheCompanion(
      id: Value(id),
      data: Value(data),
      nome: Value(nome),
      tipo: Value(tipo),
      codigoIBGE: Value(codigoIBGE),
      ano: Value(ano),
    );
  }

  factory FeriadoCacheRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeriadoCacheRow(
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
      nome: serializer.fromJson<String>(json['nome']),
      tipo: serializer.fromJson<String>(json['tipo']),
      codigoIBGE: serializer.fromJson<String>(json['codigoIBGE']),
      ano: serializer.fromJson<int>(json['ano']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
      'nome': serializer.toJson<String>(nome),
      'tipo': serializer.toJson<String>(tipo),
      'codigoIBGE': serializer.toJson<String>(codigoIBGE),
      'ano': serializer.toJson<int>(ano),
    };
  }

  FeriadoCacheRow copyWith(
          {int? id,
          String? data,
          String? nome,
          String? tipo,
          String? codigoIBGE,
          int? ano}) =>
      FeriadoCacheRow(
        id: id ?? this.id,
        data: data ?? this.data,
        nome: nome ?? this.nome,
        tipo: tipo ?? this.tipo,
        codigoIBGE: codigoIBGE ?? this.codigoIBGE,
        ano: ano ?? this.ano,
      );
  FeriadoCacheRow copyWithCompanion(FeriadosCacheCompanion data) {
    return FeriadoCacheRow(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
      nome: data.nome.present ? data.nome.value : this.nome,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      codigoIBGE:
          data.codigoIBGE.present ? data.codigoIBGE.value : this.codigoIBGE,
      ano: data.ano.present ? data.ano.value : this.ano,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeriadoCacheRow(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('nome: $nome, ')
          ..write('tipo: $tipo, ')
          ..write('codigoIBGE: $codigoIBGE, ')
          ..write('ano: $ano')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data, nome, tipo, codigoIBGE, ano);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeriadoCacheRow &&
          other.id == this.id &&
          other.data == this.data &&
          other.nome == this.nome &&
          other.tipo == this.tipo &&
          other.codigoIBGE == this.codigoIBGE &&
          other.ano == this.ano);
}

class FeriadosCacheCompanion extends UpdateCompanion<FeriadoCacheRow> {
  final Value<int> id;
  final Value<String> data;
  final Value<String> nome;
  final Value<String> tipo;
  final Value<String> codigoIBGE;
  final Value<int> ano;
  const FeriadosCacheCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.nome = const Value.absent(),
    this.tipo = const Value.absent(),
    this.codigoIBGE = const Value.absent(),
    this.ano = const Value.absent(),
  });
  FeriadosCacheCompanion.insert({
    this.id = const Value.absent(),
    required String data,
    required String nome,
    required String tipo,
    required String codigoIBGE,
    required int ano,
  })  : data = Value(data),
        nome = Value(nome),
        tipo = Value(tipo),
        codigoIBGE = Value(codigoIBGE),
        ano = Value(ano);
  static Insertable<FeriadoCacheRow> custom({
    Expression<int>? id,
    Expression<String>? data,
    Expression<String>? nome,
    Expression<String>? tipo,
    Expression<String>? codigoIBGE,
    Expression<int>? ano,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (nome != null) 'nome': nome,
      if (tipo != null) 'tipo': tipo,
      if (codigoIBGE != null) 'codigo_i_b_g_e': codigoIBGE,
      if (ano != null) 'ano': ano,
    });
  }

  FeriadosCacheCompanion copyWith(
      {Value<int>? id,
      Value<String>? data,
      Value<String>? nome,
      Value<String>? tipo,
      Value<String>? codigoIBGE,
      Value<int>? ano}) {
    return FeriadosCacheCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      codigoIBGE: codigoIBGE ?? this.codigoIBGE,
      ano: ano ?? this.ano,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (codigoIBGE.present) {
      map['codigo_i_b_g_e'] = Variable<String>(codigoIBGE.value);
    }
    if (ano.present) {
      map['ano'] = Variable<int>(ano.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeriadosCacheCompanion(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('nome: $nome, ')
          ..write('tipo: $tipo, ')
          ..write('codigoIBGE: $codigoIBGE, ')
          ..write('ano: $ano')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AlarmesTable alarmes = $AlarmesTable(this);
  late final $EscalasUsuarioTable escalasUsuario = $EscalasUsuarioTable(this);
  late final $LocalizacoesTable localizacoes = $LocalizacoesTable(this);
  late final $FeriadosCacheTable feriadosCache = $FeriadosCacheTable(this);
  late final AlarmeDao alarmeDao = AlarmeDao(this as AppDatabase);
  late final EscalaUsuarioDao escalaUsuarioDao =
      EscalaUsuarioDao(this as AppDatabase);
  late final LocalizacaoDao localizacaoDao =
      LocalizacaoDao(this as AppDatabase);
  late final FeriadoCacheDao feriadoCacheDao =
      FeriadoCacheDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [alarmes, escalasUsuario, localizacoes, feriadosCache];
}

typedef $$AlarmesTableCreateCompanionBuilder = AlarmesCompanion Function({
  Value<int> id,
  required String hora,
  required int diasDaSemana,
  Value<bool> ativo,
  Value<String> titulo,
});
typedef $$AlarmesTableUpdateCompanionBuilder = AlarmesCompanion Function({
  Value<int> id,
  Value<String> hora,
  Value<int> diasDaSemana,
  Value<bool> ativo,
  Value<String> titulo,
});

class $$AlarmesTableFilterComposer
    extends Composer<_$AppDatabase, $AlarmesTable> {
  $$AlarmesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hora => $composableBuilder(
      column: $table.hora, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasDaSemana => $composableBuilder(
      column: $table.diasDaSemana, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnFilters(column));
}

class $$AlarmesTableOrderingComposer
    extends Composer<_$AppDatabase, $AlarmesTable> {
  $$AlarmesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hora => $composableBuilder(
      column: $table.hora, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasDaSemana => $composableBuilder(
      column: $table.diasDaSemana,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get ativo => $composableBuilder(
      column: $table.ativo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titulo => $composableBuilder(
      column: $table.titulo, builder: (column) => ColumnOrderings(column));
}

class $$AlarmesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlarmesTable> {
  $$AlarmesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hora =>
      $composableBuilder(column: $table.hora, builder: (column) => column);

  GeneratedColumn<int> get diasDaSemana => $composableBuilder(
      column: $table.diasDaSemana, builder: (column) => column);

  GeneratedColumn<bool> get ativo =>
      $composableBuilder(column: $table.ativo, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);
}

class $$AlarmesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlarmesTable,
    AlarmeRow,
    $$AlarmesTableFilterComposer,
    $$AlarmesTableOrderingComposer,
    $$AlarmesTableAnnotationComposer,
    $$AlarmesTableCreateCompanionBuilder,
    $$AlarmesTableUpdateCompanionBuilder,
    (AlarmeRow, BaseReferences<_$AppDatabase, $AlarmesTable, AlarmeRow>),
    AlarmeRow,
    PrefetchHooks Function()> {
  $$AlarmesTableTableManager(_$AppDatabase db, $AlarmesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> hora = const Value.absent(),
            Value<int> diasDaSemana = const Value.absent(),
            Value<bool> ativo = const Value.absent(),
            Value<String> titulo = const Value.absent(),
          }) =>
              AlarmesCompanion(
            id: id,
            hora: hora,
            diasDaSemana: diasDaSemana,
            ativo: ativo,
            titulo: titulo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String hora,
            required int diasDaSemana,
            Value<bool> ativo = const Value.absent(),
            Value<String> titulo = const Value.absent(),
          }) =>
              AlarmesCompanion.insert(
            id: id,
            hora: hora,
            diasDaSemana: diasDaSemana,
            ativo: ativo,
            titulo: titulo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlarmesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlarmesTable,
    AlarmeRow,
    $$AlarmesTableFilterComposer,
    $$AlarmesTableOrderingComposer,
    $$AlarmesTableAnnotationComposer,
    $$AlarmesTableCreateCompanionBuilder,
    $$AlarmesTableUpdateCompanionBuilder,
    (AlarmeRow, BaseReferences<_$AppDatabase, $AlarmesTable, AlarmeRow>),
    AlarmeRow,
    PrefetchHooks Function()>;
typedef $$EscalasUsuarioTableCreateCompanionBuilder = EscalasUsuarioCompanion
    Function({
  Value<int> id,
  required String tipo,
  required int diasTrabalho,
  required int diasFolga,
  required String dataInicioReferencia,
});
typedef $$EscalasUsuarioTableUpdateCompanionBuilder = EscalasUsuarioCompanion
    Function({
  Value<int> id,
  Value<String> tipo,
  Value<int> diasTrabalho,
  Value<int> diasFolga,
  Value<String> dataInicioReferencia,
});

class $$EscalasUsuarioTableFilterComposer
    extends Composer<_$AppDatabase, $EscalasUsuarioTable> {
  $$EscalasUsuarioTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasTrabalho => $composableBuilder(
      column: $table.diasTrabalho, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diasFolga => $composableBuilder(
      column: $table.diasFolga, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataInicioReferencia => $composableBuilder(
      column: $table.dataInicioReferencia,
      builder: (column) => ColumnFilters(column));
}

class $$EscalasUsuarioTableOrderingComposer
    extends Composer<_$AppDatabase, $EscalasUsuarioTable> {
  $$EscalasUsuarioTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasTrabalho => $composableBuilder(
      column: $table.diasTrabalho,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diasFolga => $composableBuilder(
      column: $table.diasFolga, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataInicioReferencia => $composableBuilder(
      column: $table.dataInicioReferencia,
      builder: (column) => ColumnOrderings(column));
}

class $$EscalasUsuarioTableAnnotationComposer
    extends Composer<_$AppDatabase, $EscalasUsuarioTable> {
  $$EscalasUsuarioTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get diasTrabalho => $composableBuilder(
      column: $table.diasTrabalho, builder: (column) => column);

  GeneratedColumn<int> get diasFolga =>
      $composableBuilder(column: $table.diasFolga, builder: (column) => column);

  GeneratedColumn<String> get dataInicioReferencia => $composableBuilder(
      column: $table.dataInicioReferencia, builder: (column) => column);
}

class $$EscalasUsuarioTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EscalasUsuarioTable,
    EscalaUsuarioRow,
    $$EscalasUsuarioTableFilterComposer,
    $$EscalasUsuarioTableOrderingComposer,
    $$EscalasUsuarioTableAnnotationComposer,
    $$EscalasUsuarioTableCreateCompanionBuilder,
    $$EscalasUsuarioTableUpdateCompanionBuilder,
    (
      EscalaUsuarioRow,
      BaseReferences<_$AppDatabase, $EscalasUsuarioTable, EscalaUsuarioRow>
    ),
    EscalaUsuarioRow,
    PrefetchHooks Function()> {
  $$EscalasUsuarioTableTableManager(
      _$AppDatabase db, $EscalasUsuarioTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EscalasUsuarioTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EscalasUsuarioTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EscalasUsuarioTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<int> diasTrabalho = const Value.absent(),
            Value<int> diasFolga = const Value.absent(),
            Value<String> dataInicioReferencia = const Value.absent(),
          }) =>
              EscalasUsuarioCompanion(
            id: id,
            tipo: tipo,
            diasTrabalho: diasTrabalho,
            diasFolga: diasFolga,
            dataInicioReferencia: dataInicioReferencia,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String tipo,
            required int diasTrabalho,
            required int diasFolga,
            required String dataInicioReferencia,
          }) =>
              EscalasUsuarioCompanion.insert(
            id: id,
            tipo: tipo,
            diasTrabalho: diasTrabalho,
            diasFolga: diasFolga,
            dataInicioReferencia: dataInicioReferencia,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EscalasUsuarioTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EscalasUsuarioTable,
    EscalaUsuarioRow,
    $$EscalasUsuarioTableFilterComposer,
    $$EscalasUsuarioTableOrderingComposer,
    $$EscalasUsuarioTableAnnotationComposer,
    $$EscalasUsuarioTableCreateCompanionBuilder,
    $$EscalasUsuarioTableUpdateCompanionBuilder,
    (
      EscalaUsuarioRow,
      BaseReferences<_$AppDatabase, $EscalasUsuarioTable, EscalaUsuarioRow>
    ),
    EscalaUsuarioRow,
    PrefetchHooks Function()>;
typedef $$LocalizacoesTableCreateCompanionBuilder = LocalizacoesCompanion
    Function({
  Value<int> id,
  required String cidade,
  required String estado,
  required String codigoIBGE,
});
typedef $$LocalizacoesTableUpdateCompanionBuilder = LocalizacoesCompanion
    Function({
  Value<int> id,
  Value<String> cidade,
  Value<String> estado,
  Value<String> codigoIBGE,
});

class $$LocalizacoesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalizacoesTable> {
  $$LocalizacoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigoIBGE => $composableBuilder(
      column: $table.codigoIBGE, builder: (column) => ColumnFilters(column));
}

class $$LocalizacoesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalizacoesTable> {
  $$LocalizacoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cidade => $composableBuilder(
      column: $table.cidade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigoIBGE => $composableBuilder(
      column: $table.codigoIBGE, builder: (column) => ColumnOrderings(column));
}

class $$LocalizacoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalizacoesTable> {
  $$LocalizacoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cidade =>
      $composableBuilder(column: $table.cidade, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get codigoIBGE => $composableBuilder(
      column: $table.codigoIBGE, builder: (column) => column);
}

class $$LocalizacoesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalizacoesTable,
    LocalizacaoRow,
    $$LocalizacoesTableFilterComposer,
    $$LocalizacoesTableOrderingComposer,
    $$LocalizacoesTableAnnotationComposer,
    $$LocalizacoesTableCreateCompanionBuilder,
    $$LocalizacoesTableUpdateCompanionBuilder,
    (
      LocalizacaoRow,
      BaseReferences<_$AppDatabase, $LocalizacoesTable, LocalizacaoRow>
    ),
    LocalizacaoRow,
    PrefetchHooks Function()> {
  $$LocalizacoesTableTableManager(_$AppDatabase db, $LocalizacoesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalizacoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalizacoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalizacoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> cidade = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String> codigoIBGE = const Value.absent(),
          }) =>
              LocalizacoesCompanion(
            id: id,
            cidade: cidade,
            estado: estado,
            codigoIBGE: codigoIBGE,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String cidade,
            required String estado,
            required String codigoIBGE,
          }) =>
              LocalizacoesCompanion.insert(
            id: id,
            cidade: cidade,
            estado: estado,
            codigoIBGE: codigoIBGE,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalizacoesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalizacoesTable,
    LocalizacaoRow,
    $$LocalizacoesTableFilterComposer,
    $$LocalizacoesTableOrderingComposer,
    $$LocalizacoesTableAnnotationComposer,
    $$LocalizacoesTableCreateCompanionBuilder,
    $$LocalizacoesTableUpdateCompanionBuilder,
    (
      LocalizacaoRow,
      BaseReferences<_$AppDatabase, $LocalizacoesTable, LocalizacaoRow>
    ),
    LocalizacaoRow,
    PrefetchHooks Function()>;
typedef $$FeriadosCacheTableCreateCompanionBuilder = FeriadosCacheCompanion
    Function({
  Value<int> id,
  required String data,
  required String nome,
  required String tipo,
  required String codigoIBGE,
  required int ano,
});
typedef $$FeriadosCacheTableUpdateCompanionBuilder = FeriadosCacheCompanion
    Function({
  Value<int> id,
  Value<String> data,
  Value<String> nome,
  Value<String> tipo,
  Value<String> codigoIBGE,
  Value<int> ano,
});

class $$FeriadosCacheTableFilterComposer
    extends Composer<_$AppDatabase, $FeriadosCacheTable> {
  $$FeriadosCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigoIBGE => $composableBuilder(
      column: $table.codigoIBGE, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ano => $composableBuilder(
      column: $table.ano, builder: (column) => ColumnFilters(column));
}

class $$FeriadosCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $FeriadosCacheTable> {
  $$FeriadosCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigoIBGE => $composableBuilder(
      column: $table.codigoIBGE, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ano => $composableBuilder(
      column: $table.ano, builder: (column) => ColumnOrderings(column));
}

class $$FeriadosCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeriadosCacheTable> {
  $$FeriadosCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get codigoIBGE => $composableBuilder(
      column: $table.codigoIBGE, builder: (column) => column);

  GeneratedColumn<int> get ano =>
      $composableBuilder(column: $table.ano, builder: (column) => column);
}

class $$FeriadosCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FeriadosCacheTable,
    FeriadoCacheRow,
    $$FeriadosCacheTableFilterComposer,
    $$FeriadosCacheTableOrderingComposer,
    $$FeriadosCacheTableAnnotationComposer,
    $$FeriadosCacheTableCreateCompanionBuilder,
    $$FeriadosCacheTableUpdateCompanionBuilder,
    (
      FeriadoCacheRow,
      BaseReferences<_$AppDatabase, $FeriadosCacheTable, FeriadoCacheRow>
    ),
    FeriadoCacheRow,
    PrefetchHooks Function()> {
  $$FeriadosCacheTableTableManager(_$AppDatabase db, $FeriadosCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeriadosCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeriadosCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeriadosCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> data = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> codigoIBGE = const Value.absent(),
            Value<int> ano = const Value.absent(),
          }) =>
              FeriadosCacheCompanion(
            id: id,
            data: data,
            nome: nome,
            tipo: tipo,
            codigoIBGE: codigoIBGE,
            ano: ano,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String data,
            required String nome,
            required String tipo,
            required String codigoIBGE,
            required int ano,
          }) =>
              FeriadosCacheCompanion.insert(
            id: id,
            data: data,
            nome: nome,
            tipo: tipo,
            codigoIBGE: codigoIBGE,
            ano: ano,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FeriadosCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FeriadosCacheTable,
    FeriadoCacheRow,
    $$FeriadosCacheTableFilterComposer,
    $$FeriadosCacheTableOrderingComposer,
    $$FeriadosCacheTableAnnotationComposer,
    $$FeriadosCacheTableCreateCompanionBuilder,
    $$FeriadosCacheTableUpdateCompanionBuilder,
    (
      FeriadoCacheRow,
      BaseReferences<_$AppDatabase, $FeriadosCacheTable, FeriadoCacheRow>
    ),
    FeriadoCacheRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AlarmesTableTableManager get alarmes =>
      $$AlarmesTableTableManager(_db, _db.alarmes);
  $$EscalasUsuarioTableTableManager get escalasUsuario =>
      $$EscalasUsuarioTableTableManager(_db, _db.escalasUsuario);
  $$LocalizacoesTableTableManager get localizacoes =>
      $$LocalizacoesTableTableManager(_db, _db.localizacoes);
  $$FeriadosCacheTableTableManager get feriadosCache =>
      $$FeriadosCacheTableTableManager(_db, _db.feriadosCache);
}
