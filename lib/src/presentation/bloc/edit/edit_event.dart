part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}

class GetAllData extends EditEvent {
  const GetAllData();

  @override
  List<Object> get props => [];
}

class ResetAllData extends EditEvent {}

class FilterAllData extends EditEvent {
  final String filterText;

  const FilterAllData(this.filterText);

  @override
  List<Object> get props => [filterText];
}

class RemoveTaboo extends EditEvent {
  final Taboo taboo;

  const RemoveTaboo(this.taboo);

  @override
  List<Object> get props => [taboo];
}
