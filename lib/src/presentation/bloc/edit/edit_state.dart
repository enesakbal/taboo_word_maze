part of 'edit_bloc.dart';

abstract class EditState extends Equatable {
  const EditState({
    required this.dataList,
  });

  final List<Taboo> dataList;

  @override
  List<Object> get props => [dataList];
}

class FetchedDataFromLocal extends EditState {
  const FetchedDataFromLocal({required super.dataList});

  @override
  List<Object> get props => [dataList];
}
class FilteredAllData extends EditState {
  const FilteredAllData({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class EditInitial extends EditState {
  const EditInitial({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class EditedTaboo extends EditState {
  const EditedTaboo({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class RemovedTaboo extends EditState {
  const RemovedTaboo({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class AddedNewTaboo extends EditState {
  const AddedNewTaboo({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class FetchedDataFromFirebase extends EditState {
  const FetchedDataFromFirebase({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class ResetedAllData extends EditState {
  const ResetedAllData({required super.dataList});

  @override
  List<Object> get props => [dataList];
}

class EditError extends EditState {
  const EditError({required super.dataList});

  @override
  List<Object> get props => [dataList];
}
