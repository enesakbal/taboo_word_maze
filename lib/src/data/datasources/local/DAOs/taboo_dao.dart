import 'package:floor/floor.dart';

import '../../../../core/constants/local_db_constants.dart';
import '../../../../domain/entities/taboo.dart';

@dao
abstract class TabooDao {
  @Query("SELECT * FROM ${LocalDBConstants.tabooTable} WHERE LANGUAGE = 'TR'")
  Future<List<Taboo>> getAllTabooTR();

  @Query("SELECT * FROM ${LocalDBConstants.tabooTable} WHERE LANGUAGE = 'EN'")
  Future<List<Taboo>> getAllTabooEN();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertANewTaboo(Taboo taboo);

  @delete
  Future<void> deleteATaboo(Taboo taboo);

  @update
  Future<void> updateATaboo(Taboo newTaboo);

  @Query('DELETE FROM ${LocalDBConstants.tabooTable} ')
  Future<void> deleteAllTaboos();
}
