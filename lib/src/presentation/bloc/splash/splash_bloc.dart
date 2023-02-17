import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../core/init/lang/locale_keys.g.dart';
import '../../../domain/entities/taboo.dart';
import '../../../domain/usecaces/firebase_document_usecase.dart';
import '../../../domain/usecaces/taboo_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TabooUsecase tabooUsecase;
  final FirebaseDocumentUsecase firebaseDocumentUsecase;
  SplashBloc(this.tabooUsecase, this.firebaseDocumentUsecase)
      : super(SplashInitial()) {
          


    on<BusinessDesicion>(
      (event, emit) async {
        try {
          emit(const SplashLoading());
          // await Future.delayed(const Duration(seconds: 2));

          final result = await tabooUsecase.hasAnUpdate();

          await result.fold(
            (failure) {
              add(const FetchDataFromLocalDB(hasInternetConnection: false));
              /**There is no internet. This error from cloud_firestore */
            },
            (hasUpdate) async {
              if (hasUpdate) {
                emit(NeedUpdate(message: LocaleKeys.errors_has_update.tr()));
                /** If has an internet connection and need update */
                await firebaseDocumentUsecase.saveToken();
                return;
              } else {
                add(const FetchDataFromLocalDB(hasInternetConnection: true));
                /** if has an internet connection and dont need update */
                return;
              }
            },
          );
        } on FirebaseException catch (_) {
          emit(SplashError(message: LocaleKeys.errors_an_error.tr()));
          /** if has an error */
        }
      },
    );

    on<FetchDataFromLocalDB>((event, emit) async {
      try {
        final tabooListFromLocalDB = await tabooUsecase.getAllTaboos();
        /** fetching local data */

        if (tabooListFromLocalDB.isNotEmpty) {
          if (event.hasInternetConnection) {
            await firebaseDocumentUsecase.saveToken();
            /** save fcm token to firestore if has an internet connection*/
          }

          /** if has local data. it doesn't matter if there is an update or not.*/
          // print(tabooListFromLocalDB);
          emit(SplashLocalDBHasData(data: tabooListFromLocalDB));
          /** this is a decision. i want to user can use my app in this case(has not an internet conn but has local data)*/
          return;
        } else {
          if (event.hasInternetConnection == false) {
            /** if has not local data and internet conn */
            emit(const SplashError(
                message: LocaleKeys.errors_no_internet_first_open));
            return;
          } else {
            /** if has not local data but has internet conn */
            add(const FetchDataFromFirebase());
            /** so we need to fetch all data from firebase */
            return;
          }
        }
      } on Exception catch (_) {
        emit(SplashError(message: LocaleKeys.errors_an_error.tr()));
      }
    });

    on<FetchDataFromFirebase>((event, emit) async {
      try {
        final result = await tabooUsecase.getAllTaboosFromFirebase();
        /** trying to fetch data from firebase */

        await result.fold(
          (failure) {
            emit(SplashError(message: failure.toString()));
          },
          /** if has an erro while fetching data */
          (data) async {
            /** request success */

            await firebaseDocumentUsecase.saveToken();
            /** save fcm token to firestore*/

            if (data.isEmpty) {
              emit(SplashError(message: LocaleKeys.errors_no_data.tr()));
              /** if firebase data is empty */
              return;
            }

            for (final e in data) {
              await tabooUsecase.insertANewTaboo(newTaboo: e);
              /** if firebase data is not empty so we can add all taboo to local db */
            }

            emit(SplashFetchedDataFromFirebase(data: data));
            /** if everything is awesome  */
          },
        );
      } on FirebaseException catch (_) {
        emit(SplashError(message: LocaleKeys.errors_an_error.tr()));
        /** if has an error */
      }
    });
  }
}
