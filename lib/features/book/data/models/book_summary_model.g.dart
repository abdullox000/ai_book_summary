// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookSummaryModel _$BookSummaryModelFromJson(Map<String, dynamic> json) =>
    _BookSummaryModel(
      summary: json['summary'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      author: json['author'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$BookSummaryModelToJson(_BookSummaryModel instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'rating': instance.rating,
      'author': instance.author,
      'title': instance.title,
    };
