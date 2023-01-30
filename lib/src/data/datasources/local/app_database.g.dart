// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TabooDao? _taboInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Taboo` (`word` TEXT, `forbiddenWords` TEXT, PRIMARY KEY (`word`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TabooDao get tabo {
    return _taboInstance ??= _$TabooDao(database, changeListener);
  }
}

class _$TabooDao extends TabooDao {
  _$TabooDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tabooInsertionAdapter = InsertionAdapter(
            database,
            'Taboo',
            (Taboo item) => <String, Object?>{
                  'word': item.word,
                  'forbiddenWords': item.forbiddenWords
                }),
        _tabooUpdateAdapter = UpdateAdapter(
            database,
            'Taboo',
            ['word'],
            (Taboo item) => <String, Object?>{
                  'word': item.word,
                  'forbiddenWords': item.forbiddenWords
                }),
        _tabooDeletionAdapter = DeletionAdapter(
            database,
            'Taboo',
            ['word'],
            (Taboo item) => <String, Object?>{
                  'word': item.word,
                  'forbiddenWords': item.forbiddenWords
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Taboo> _tabooInsertionAdapter;

  final UpdateAdapter<Taboo> _tabooUpdateAdapter;

  final DeletionAdapter<Taboo> _tabooDeletionAdapter;

  @override
  Future<List<Taboo>> getAllTaboo() async {
    return _queryAdapter.queryList('SELECT * FROM Taboo',
        mapper: (Map<String, Object?> row) => Taboo(
            word: row['word'] as String?,
            forbiddenWords: row['forbiddenWords'] as String?));
  }

  @override
  Future<void> dropTabooTable() async {
    await _queryAdapter.queryNoReturn('DROP TABLE IF EXISTS Taboo');
  }

  @override
  Future<void> insertANewTaboo(Taboo taboo) async {
    await _tabooInsertionAdapter.insert(taboo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateATaboo(Taboo newTaboo) async {
    await _tabooUpdateAdapter.update(newTaboo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteATaboo(Taboo taboo) async {
    await _tabooDeletionAdapter.delete(taboo);
  }
}
