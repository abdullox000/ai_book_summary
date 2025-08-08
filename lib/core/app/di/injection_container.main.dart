part of 'injection_container.dart';

final locator = GetIt.instance;

Future<void> initDI() async {
  locator.registerLazySingleton<Dio>(
    () => Dio()..interceptors.add(PrettyDioLogger()),
  );
  _initBook();
}

Future<void> _initBook() async {
  locator
    ..registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl(dio: locator<Dio>()),
    )
    ..registerLazySingleton<BookRepo>(
      () => BookRepoImpl(bookRemoteDataSource: locator<BookRemoteDataSource>()),
    )
    ..registerLazySingleton<GetBookSummaryUsecase>(
      () => GetBookSummaryUsecase(bookRepo: locator<BookRepo>()),
    )
    ..registerLazySingleton<BookController>(
      () => BookController(
        getBookSummaryUsecase: locator<GetBookSummaryUsecase>(),
      ),
    );
}
