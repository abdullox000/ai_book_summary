import 'package:ai_book_summary_app/features/book/data/models/book_summary_model.dart';
import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';

extension BookMapper on BookSummaryModel {
  BookSummaryEntity toEntity() {
    return BookSummaryEntity(
      rating: rating,
      summary: summary,
      author: author,
      title: title,
      createdAt: createdAt
    );
  }
}
