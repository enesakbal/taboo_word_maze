// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'round.dart';

class Team extends Equatable {
  final String teamName;
  final int point;
  final List<Round> roundList;

  const Team({
    required this.teamName,
    required this.point,
    required this.roundList,
  });

  @override
  List<Object> get props => [teamName, point, roundList];
}
