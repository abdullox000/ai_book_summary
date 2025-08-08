import 'dart:developer';

import 'package:get/get.dart';

import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
import 'package:ai_book_summary_app/features/book/domain/usecases/get_book_summary_usecase.dart';

class BookController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BookSummaryEntity> summaries = <BookSummaryEntity>[].obs;

  GetBookSummaryUsecase getBookSummaryUsecase;
  BookController({required this.getBookSummaryUsecase});

  Future<BookSummaryEntity?> getBookSummary({
    required String author,
    required String book,
  }) async {
    isLoading.value = true;
    final result = await getBookSummaryUsecase(
      params: GetBookSummaryUsecaseParams(author: author, book: book),
    );

    result.fold(
      (l) {
        log(l.message);
      },
      (r) {
        summaries.add(r);
        return r;
      },
    );
    isLoading.value = false;
  }
}
