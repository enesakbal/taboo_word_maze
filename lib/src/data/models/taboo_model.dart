import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/taboo.dart';

part 'taboo_model.g.dart';

@JsonSerializable()
class TabooModel extends Equatable {
  @JsonKey(name: 'word')
  final String? word;
  @JsonKey(name: 'forbidden_words')
  final List<String>? forbiddenWords;

  const TabooModel({this.word, this.forbiddenWords});

  factory TabooModel.fromJson(Map<String, dynamic> json) {
    return _$TabooModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TabooModelToJson(this);

  Taboo toEntity() {
    // var customForbiddenWords = '';

    final buffer = StringBuffer();

    for (final e in forbiddenWords!) {
      // customForbiddenWords += '$e,';

      buffer.write('$e,');

      //* we  can't store the array in sqlite database, so we can add a comma at the end of each word
      //* and split it with a comma and use it in future operations.
    }

    return Taboo(word: word, forbiddenWords: buffer.toString());
  }

  @override
  List<Object?> get props => [word, forbiddenWords];
}
