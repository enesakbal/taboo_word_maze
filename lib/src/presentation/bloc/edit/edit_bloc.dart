import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/taboo.dart';
import '../../../domain/usecaces/taboo_usecase.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  final TabooUsecase tabooUsecase;
  EditBloc(this.tabooUsecase)
      : super(
          const EditInitial(
            dataList: [Taboo(word: '', forbiddenWords: ',,,,', language: '')],
          ),
        ) {
    late List<Taboo> dataList;

    on<GetAllData>((event, emit) async {
      dataList = await tabooUsecase.getAllTaboos();

      emit(FetchedDataFromLocal(dataList: dataList));
    });

    on<FilterAllData>((event, emit) async {
      final searchLaunchRocket = dataList.where((data) {
        final filterText = event.filterText.toLowerCase();
        final tabooWord = data.word!.toLowerCase();
        final tabooForbiddenWords = data.forbiddenWords!
            .split(',')
            .map((e) => e.toLowerCase())
            .toList();

        if (tabooWord.contains(filterText)) {
          return tabooWord.contains(filterText);
        }
        return tabooForbiddenWords.contains(event.filterText);

        // return titleLower!.contains(event.value);
      }).toList();

      emit(FilteredAllData(dataList: searchLaunchRocket));
    });

    on<RemoveTaboo>((event, emit) async {
      emit(const EditInitial(dataList: []));
      await Future.delayed(const Duration(milliseconds: 100));

      await tabooUsecase.deleteTaboo(deleteTaboo: event.taboo);
      dataList.remove(event.taboo);

      emit(RemovedTaboo(dataList: dataList));
    });
  }
}
