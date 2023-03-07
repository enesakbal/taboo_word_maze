// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taboo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TabooModel _$TabooModelFromJson(Map<String, dynamic> json) => TabooModel(
      word: json['word'] as String?,
      forbiddenWords: (json['forbidden_words'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['_language'] as String?,
    );

Map<String, dynamic> _$TabooModelToJson(TabooModel instance) =>
    <String, dynamic>{
      'word': instance.word,
      'forbidden_words': instance.forbiddenWords,
      '_language': instance.language,
    };
