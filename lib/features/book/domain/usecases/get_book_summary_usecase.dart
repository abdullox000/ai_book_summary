import 'package:ai_book_summary_app/core/app/typdefs/typedefs.dart';
import 'package:ai_book_summary_app/core/app/usecases/usecase.dart';
import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
import 'package:ai_book_summary_app/features/book/domain/repos/book_repo.dart';

class GetBookSummaryUsecase
    extends UsecaseWithParams<BookSummaryEntity, GetBookSummaryUsecaseParams> {
  final BookRepo bookRepo;

  GetBookSummaryUsecase({required this.bookRepo});

  @override
  ResultFuture<BookSummaryEntity> call({
    required GetBookSummaryUsecaseParams params,
  }) async {
    return await bookRepo.getBookSummary(
      author: params.author,
      book: params.book,
    );
  }
}

class GetBookSummaryUsecaseParams {
  final String author;
  final String book;

  GetBookSummaryUsecaseParams({required this.author, required this.book});
}
