import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_summary_model.freezed.dart';
part 'book_summary_model.g.dart';

@freezed
abstract class BookSummaryModel with _$BookSummaryModel {
  const factory BookSummaryModel({
    String? summary,
    int? rating,
    String? author,
    String? title,
    DateTime? createdAt
  }) = _BookSummaryModel;

  factory BookSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$BookSummaryModelFromJson(json);
}
