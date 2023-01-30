import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/entities/taboo.dart';
import 'DAOs/taboo_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Taboo])
abstract class AppDatabase extends FloorDatabase {
  TabooDao get tabo;
}
