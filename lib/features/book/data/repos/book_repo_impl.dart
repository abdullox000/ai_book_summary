import 'package:ai_book_summary_app/core/app/errors/server_exception.dart';
import 'package:ai_book_summary_app/core/app/typdefs/typedefs.dart';
import 'package:ai_book_summary_app/features/book/data/mappers/book_mapper.dart';
import 'package:ai_book_summary_app/features/book/data/source/book_remote_data_source.dart';
import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
import 'package:ai_book_summary_app/features/book/domain/repos/book_repo.dart';
import 'package:dartz/dartz.dart';

class BookRepoImpl implements BookRepo {
  final BookRemoteDataSource bookRemoteDataSource;

  BookRepoImpl({required this.bookRemoteDataSource});

  @override
  ResultFuture<BookSummaryEntity> getBookSummary({
    required String author,
    required String book,
  }) async {
    try {
      final result = await bookRemoteDataSource.getBookSummary(
        author: author,
        book: book,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(e);
    }
  }
}
