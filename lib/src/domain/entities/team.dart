// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'round.dart';

class Team extends Equatable {
  final String? teamName;
  int? totalScore;
  List<Round?>? roundList;

  Team({
    this.teamName = '',
    this.totalScore = 0,
    this.roundList = const [],
  });

  void increaseAPoint() => totalScore = totalScore! + 1;
  void decreaseAPoint() => totalScore = totalScore! - 1;

  @override
  List<Object?> get props => [teamName, totalScore, roundList];
}
