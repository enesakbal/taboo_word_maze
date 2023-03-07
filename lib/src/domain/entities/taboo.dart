import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Taboo extends Equatable {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'WORD')
  final String? word;
  @ColumnInfo(name: 'FORBIDDEN_WORDS')
  final String? forbiddenWords;
  @ColumnInfo(name: 'LANGUAGE')
  final String? language;

  const Taboo(
      {required this.word,
      required this.forbiddenWords,
      required this.language});

  factory Taboo.fromJson(Map<String, dynamic> json) => Taboo(
        word: json['word'] as String?,
        forbiddenWords: json['forbidden_words'] as String?,
        language: json['_language'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'word': word,
        'forbidden_words': forbiddenWords,
        '_language': language,
      };

  @override
  List<Object?> get props => [word, forbiddenWords,language];
}
