import 'package:floor/floor.dart';

import '../../../../core/constants/local_db_constants.dart';
import '../../../../domain/entities/taboo.dart';

@dao
abstract class TabooDao {
  @Query('SELECT * FROM ${LocalDBConstants.tabooTable}')
  Future<List<Taboo>> getAllTaboo();

  @insert
  Future<void> insertANewTaboo(Taboo taboo);

  @delete
  Future<void> deleteATaboo(Taboo taboo);

  @update
  Future<void> updateATaboo(Taboo newTaboo);

  @Query('DROP TABLE IF EXISTS ${LocalDBConstants.tabooTable} ')
  Future<void> dropTabooTable();
}
