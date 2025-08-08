import 'package:ai_book_summary_app/core/app/di/injection_container.dart';
import 'package:ai_book_summary_app/features/book/presentation/controller/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _titleCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final BookController c;

  @override
  void initState() {
    super.initState();
    c = Get.put<BookController>(locator<BookController>());
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    super.dispose();
  }

  void _summarize() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    try {
      await c.getBookSummary(
        book: _titleCtrl.text.trim(),
        author: _authorCtrl.text.trim(),
      );
    } catch (e) {
      Get.snackbar(
        'Xatolik',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // controller should set isLoading=false itself;
      // if not, you can also toggle here.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Book Summary'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/history'),
            icon: const Icon(Icons.history),
            tooltip: 'History',
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Input card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Book title',
                          hintText: 'e.g. Atomic Habits',
                          prefixIcon: Icon(Icons.menu_book_rounded),
                        ),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _authorCtrl,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Author (optional)',
                          hintText: 'e.g. James Clear',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: c.isLoading.value
                                ? null
                                : () => _summarize(),
                            icon: c.isLoading.value
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.auto_awesome),
                            label: Text(
                              c.isLoading.value
                                  ? 'Summarizing...'
                                  : 'Summarize',
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Result card
              Obx(() {
                if (c.summaries.isEmpty) {
                  return _EmptyState(theme: theme);
                }
                final last = c.summaries.last;

                // Adjust these field names to match your BookSummaryEntity
                final String book = (last.author).toString();
                final String author = (last.title).toString();
                final String summary = (last.summary ?? '').toString();
                final int rating = (last.rating is int)
                    ? last.rating!
                    : int.tryParse('${last.rating}') ?? 0;

                return _ResultCard(
                  title: book,
                  author: author,
                  summary: summary,
                  rating: rating.clamp(0, 5),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.menu_book_outlined, size: 64),
          const SizedBox(height: 12),
          Text(
            'Enter a book to get a summary',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Add an author for better accuracy',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.title,
    required this.author,
    required this.summary,
    required this.rating,
  });

  final String title;
  final String author;
  final String summary;
  final int rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (author.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(author, style: theme.textTheme.bodyMedium),
                      ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(20),
                  child: Image.network(
                    width: 100,
                    height: 100,
                    "https://image.pollinations.ai/prompt/$summary",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            StarRating(value: rating, size: 22),
            const SizedBox(height: 12),
            Text(summary, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int value; // 0..5
  final double size;
  const StarRating({super.key, required this.value, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (i) => Icon(
          i < value ? Icons.star_rounded : Icons.star_border_rounded,
          size: size,
        ),
      ),
    );
  }
}
