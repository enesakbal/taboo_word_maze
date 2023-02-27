// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Round extends Equatable {
  final int roundNumber;
  final int success;
  final int fail;
  final int pass;

  const Round({
    required this.roundNumber,
    required this.success,
    required this.fail,
    required this.pass,
  });

  @override
  List<Object> get props => [roundNumber, success, fail, pass];
}
