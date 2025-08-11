import 'package:ai_book_summary_app/core/app/di/injection_container.dart';
import 'package:ai_book_summary_app/features/book/presentation/screens/book_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookSummaryScreen(),
    );
  }
}
