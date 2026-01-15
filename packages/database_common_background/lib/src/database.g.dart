// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
abstract class _$CommonBackgroundDatabase extends GeneratedDatabase {
  _$CommonBackgroundDatabase(QueryExecutor e) : super(e);
  late final DaoReadApp daoReadApp = DaoReadApp(
    this as CommonBackgroundDatabase,
  );
  late final DaoReadLoginSession daoReadLoginSession = DaoReadLoginSession(
    this as CommonBackgroundDatabase,
  );
  late final DaoWriteApp daoWriteApp = DaoWriteApp(
    this as CommonBackgroundDatabase,
  );
  late final DaoWriteLoginSession daoWriteLoginSession = DaoWriteLoginSession(
    this as CommonBackgroundDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [];
}
