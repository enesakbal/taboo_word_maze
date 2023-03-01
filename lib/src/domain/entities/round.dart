// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class Round extends Equatable {
  final int roundNumber;
  int? success;
  int? fail;
  int? pass;
  Round({
    required this.roundNumber,
    this.success = 0,
    this.fail = 0,
    this.pass = 0,
  });

  int get score => success! - fail!;

  void increaseSuccess() => success = success! + 1;
  void increaseFail() => fail = fail! + 1;
  void increasePass() => pass = pass! + 1;

  @override
  List<Object> get props => [roundNumber, success!, fail!, pass!];
}
