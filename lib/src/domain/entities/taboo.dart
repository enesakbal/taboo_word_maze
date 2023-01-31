import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Taboo extends Equatable {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo()
  final String? word;
  @ColumnInfo()
  final String? forbiddenWords;

  const Taboo({required this.word, required this.forbiddenWords});

  factory Taboo.fromJson(Map<String, dynamic> json) => Taboo(
        word: json['word'] as String?,
        forbiddenWords: json['forbidden_words'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'word': word,
        'forbidden_words': forbiddenWords,
      };

  @override
  List<Object?> get props => [word, forbiddenWords];
}
