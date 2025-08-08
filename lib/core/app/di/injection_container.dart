import 'package:ai_book_summary_app/features/book/data/repos/book_repo_impl.dart';
import 'package:ai_book_summary_app/features/book/data/source/book_remote_data_source.dart';
import 'package:ai_book_summary_app/features/book/domain/repos/book_repo.dart';
import 'package:ai_book_summary_app/features/book/domain/usecases/get_book_summary_usecase.dart';
import 'package:ai_book_summary_app/features/book/presentation/controller/book_controller.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'injection_container.main.dart';