import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../core/lang/locale_keys.g.dart';
import '../../../domain/entities/taboo.dart';
import '../../../domain/usecaces/taboo_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TabooUsecase tabooUsecase;
  SplashBloc(this.tabooUsecase) : super(SplashInitial()) {
    on<FetchData>((event, emit) async {
      // await tabooUsecase.dropTabooTable();

      // return;
      try {
        emit(const SplashLoading());
        /** loading state */

        final tabooListFromLocalDB = await tabooUsecase.getAllTaboos();

        if (tabooListFromLocalDB.isNotEmpty) {
          print(tabooListFromLocalDB.length);
          emit(SplashHasData(data: tabooListFromLocalDB));
          /** if local db has taboos so we dont need fetch them from firebase */
          return;
        }

        print(tabooListFromLocalDB);

        final result = await tabooUsecase.getAllTaboosFromFirebase();
        /** trying to fetch data from firebase */

        result.fold(
          (failure) => emit(SplashError(message: failure.toString())),
          /** if has an error */
          (data) {
            if (data.isEmpty) {
              emit(SplashNoData(message: LocaleKeys.errors_no_data.tr()));
              /** if data is empty */
              return;
            }

            for (final e in data) {
              tabooUsecase.insertANewTaboo(newTaboo: e);
              /** if data is not empty add all taboo to local db */
            }

            emit(SplashHasData(data: data));
            /** if everything is awesome  */
          },
        );
      } on Exception catch (_) {
        emit(SplashError(message: LocaleKeys.errors_no_data.tr()));
        /** if has an error */
      }
    });
  }
}
