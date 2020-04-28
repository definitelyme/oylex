import 'package:oylex/config/database/config.dart' as config;
import 'package:oylex/config/database/definitions.dart';
import 'package:oylex/services/database/database.dart';
import 'package:sqflite/sqflite.dart' as Package;

class Sqlite implements Database {
  String _path;
  int _version;
  Package.Database _sqliteDatabase;

  Sqlite() {
    initializeDatabase();
  }

  @override
  Future<void> initializeDatabase() async {
    _path = "${config.get(DATABASE_DEFINE__.DATABASE_NAME).value}.db";
    _version = config.get(DATABASE_DEFINE__.DATABASE_VERSION).value;
    _sqliteDatabase = await Package.openDatabase(_path, version: _version);

    migrate(
        "tests",
        Columns.builder()
          ..integerColumn("id", isPrimaryKey: true, autoIncrements: false, notNull: false)
          ..textColumn("name")
          ..integerColumn("value", notNull: false)
          ..doubleColumn("num")
          ..build());
  }

  void migrate(String tableName, Columns columns) async {
    var createTableQuery = "CREATE TABLE IF NOT EXISTS $tableName (${columns.format});";
//    await _sqliteDatabase.execute(createTableQuery);
    print("Query => $createTableQuery");
  }

  @override
  Future<void> create() {
    // TODO: implement create
    return null;
  }

  @override
  Future<void> get() {
    // TODO: implement get
    return null;
  }

  @override
  Future<void> update() {
    // TODO: implement update
    return null;
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    return null;
  }
}

class Columns {
  String format = "";
  Map<COL_TYPE_ENUM__, String> _typeConstraints = {
    COL_TYPE_ENUM__.NULL: "NULL",
    COL_TYPE_ENUM__.INTEGER: "INTEGER",
    COL_TYPE_ENUM__.REAL: "REAL",
    COL_TYPE_ENUM__.TEXT: "TEXT",
    COL_TYPE_ENUM__.BLOB: "BLOB",
  };

  Columns.builder();

  Columns integerColumn(
    String columnName, {
    bool autoIncrements = false,
    bool isPrimaryKey = false,
    bool notNull = true,
    bool isUnique = false,
  }) {
    format += "$columnName "
                "${_getColumnType(COL_TYPE_ENUM__.INTEGER)} "
                "${isPrimaryKey ? "PRIMARY KEY " : ""}"
                "${autoIncrements ? "AUTOINCREMENT " : ""}"
                "${notNull ? "NOT NULL " : ""}"
                "${isUnique ? "UNIQUE " : ""}"
            .trimRight() +
        ', ';
    return this;
  }

  Columns uniqueIntegerColumn(
    String columnName, {
    bool autoIncrements = false,
    bool isPrimaryKey = false,
    bool notNull = true,
  }) {
    integerColumn(columnName, autoIncrements: autoIncrements, isPrimaryKey: isPrimaryKey, notNull: notNull, isUnique: true);
    return this;
  }

  Columns textColumn(
    String columnName, {
    bool notNull = false,
    bool isUnique = false,
  }) {
    format += "$columnName "
                "${_getColumnType(COL_TYPE_ENUM__.TEXT)} "
                "${notNull ? "NOT NULL " : ""}"
                "${isUnique ? "UNIQUE " : ""}"
            .trimRight() +
        ", ";
    return this;
  }

  Columns uniqueTextColumn(
    String columnName, {
    bool notNull = true,
  }) {
    textColumn(columnName, notNull: notNull, isUnique: true);
    return this;
  }

  Columns doubleColumn(
    String columnName, {
    bool notNull = false,
    bool isUnique = false,
  }) {
    format += "$columnName "
                "${_getColumnType(COL_TYPE_ENUM__.REAL)} "
                "${notNull ? "NOT NULL " : ""}"
                "${isUnique ? "UNIQUE " : ""}"
            .trimRight() +
        ', ';
    return this;
  }

//  Columns booleanColumn(
//    String columnName, {
//    bool notNull = true,
//    bool isUnique = false,
//  }) {
//    return this;
//  }

  Columns foreignKeyColumn(
    String columnName,
    String referenceTable,
    String referenceColumn, {
    bool onDelete = true,
    String onDeleteAction = "CASCADE",
    bool onUpdate = false,
    String onUpdateAction = "NO ACTION",
  }) {
    format += "FOREIGN KEY ($columnName) "
                "REFERENCES $referenceTable($referenceColumn) "
                "${onDelete ? "ON DELETE $onDeleteAction " : ""}"
                "${onUpdate ? "ON UPDATE $onUpdateAction " : ""}"
            .trimRight() +
        ', ';
    return this;
  }

  Columns build() {
//    String trailing = format.length > 0 ? ';'.trimLeft() : '';
    // Replace the ", " with "" & append ";"
    format = format.replaceRange(format.length - 2, format.length, '');
    return this;
  }

  String _getColumnType(COL_TYPE_ENUM__ key) => _typeConstraints.entries.firstWhere((elem) => elem.key == key).value;
}

enum COL_TYPE_ENUM__ {
  NULL,
  INTEGER,
  REAL,
  TEXT,
  BLOB,
}
