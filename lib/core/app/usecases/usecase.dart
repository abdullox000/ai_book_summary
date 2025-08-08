import 'package:ai_book_summary_app/core/app/typdefs/typedefs.dart';

abstract class UsecaseWithParams<T, Params> {
  ResultFuture<T> call({required Params params});
}

abstract class UsecaseWithoutParams<T> {
  ResultFuture<T> call();
}
