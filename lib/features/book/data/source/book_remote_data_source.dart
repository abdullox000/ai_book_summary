import 'dart:convert';
import 'dart:developer';

import 'package:ai_book_summary_app/core/app/errors/server_exception.dart';
import 'package:ai_book_summary_app/core/app/helpers/gemini_api.dart';
import 'package:ai_book_summary_app/core/app/utils/constants/network_constants.dart';
import 'package:ai_book_summary_app/features/book/data/models/book_summary_model.dart';
import 'package:dio/dio.dart';

abstract class BookRemoteDataSource {
  Future<BookSummaryModel> getBookSummary({
    required String author,
    required String book,
  });
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSourceImpl({required this.dio});

  @override
  Future<BookSummaryModel> getBookSummary({
    required String author,
    required String book,
  }) async {
    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=${NetworkConstants.gemeniAPIKey}";

    final body = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  "Summarize and rate (1-5⭐) the book '$book' by $author. Return JSON with keys: summary, rating, author, title.",
            },
          ],
        },
      ],
    };
    try {
      final response = await dio.post(
        url,
        options: Options(headers: {"Content-Type": "application/json"}),
        data: body,
      );

      if (response.statusCode == 200) {
        final rawText =
            response.data["candidates"][0]["content"]["parts"][0]["text"]
                as String;
        final jsonStr = extractJsonObject(rawText);
        log("Gemini JSON: $jsonStr");

        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        return BookSummaryModel.fromJson(map);
      }

      throw ServerException(
        message: 'Gemini error: HTTP ${response.statusCode}',
        statusCode: response.statusCode ?? 500,
      );
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
