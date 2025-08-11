import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
import 'package:ai_book_summary_app/features/book/domain/usecases/get_book_summary_usecase.dart';

class BookController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BookSummaryEntity> summaries = <BookSummaryEntity>[].obs;
  RxString lastSearch = ''.obs;

  final GetBookSummaryUsecase getBookSummaryUsecase;
  final StorageService storageService;

  BookController({
    required this.getBookSummaryUsecase,
    required this.storageService,
  });

  @override
  void onInit() {
    super.onInit();
    _loadLastSearch();
  }

  Future<void> _loadLastSearch() async {
    final savedSearch = await storageService.getLastSearch();
    if (savedSearch != null && savedSearch.isNotEmpty) {
      lastSearch.value = savedSearch;
    }
  }

  Future<BookSummaryEntity?> getBookSummary({
    required String author,
    required String book,
  }) async {
    if (book.trim().isEmpty) return null;

    isLoading.value = true;

    final result = await getBookSummaryUsecase(
      params: GetBookSummaryUsecaseParams(author: author, book: book),
    );

    BookSummaryEntity? summaryResult;

    result.fold(
      (failure) {
        log('Error: ${failure.message}');
      },
      (summary) {
        summaries.add(summary);
        summaryResult = summary;
        storageService.saveLastSearch(book);
        lastSearch.value = book;
      },
    );

    isLoading.value = false;
    return summaryResult;
  }
}

class StorageService {
  static const String _keyLastSearch = 'last_search';

  Future<void> saveLastSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastSearch, query);
  }

  Future<String?> getLastSearch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastSearch);
  }
}
