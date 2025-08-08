import 'package:ai_book_summary_app/core/app/errors/server_exception.dart';
import 'package:dartz/dartz.dart';

/// typedef => biror bir tipga yangi laqab yoki nom yaratish (ya'ni ham o'zini nomi bilan ham yangi laqab bilan ham chaqirsa bo'ladi)
typedef ResultFuture<T> = Future<Either<ServerException, T>>;
typedef DataMap = Map<String, dynamic>;
