import 'package:ai_book_summary_app/core/app/typdefs/typedefs.dart';
import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';

abstract class BookRepo {
  ResultFuture<BookSummaryEntity> getBookSummary({
    required String author,
    required String book,
  });
}
