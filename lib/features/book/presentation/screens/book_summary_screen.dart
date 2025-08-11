import 'package:ai_book_summary_app/core/app/di/injection_container.dart';
import 'package:ai_book_summary_app/features/book/presentation/controller/book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookSummaryScreen extends StatefulWidget {
  const BookSummaryScreen({super.key});

  @override
  State<BookSummaryScreen> createState() => _BookSummaryScreenState();
}

enum HistorySort { newest, rating }

class _BookSummaryScreenState extends State<BookSummaryScreen> {
  final _titleCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final BookController c;
  HistorySort _sort = HistorySort.newest;

  @override
  void initState() {
    super.initState();
    c = Get.put<BookController>(locator<BookController>());
    _searchCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _authorCtrl.dispose();
    _searchCtrl.dispose();
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
    }
  }

  List<dynamic> _filtered() {
    final q = _searchCtrl.text.trim().toLowerCase();
    final list = c.summaries.toList();

    final filtered = q.isEmpty
        ? list
        : list.where((e) {
            final title = (e.title ?? '').toString().toLowerCase();
            final author = (e.author ?? '').toString().toLowerCase();
            final summary = (e.summary ?? '').toString().toLowerCase();
            return title.contains(q) ||
                author.contains(q) ||
                summary.contains(q);
          }).toList();

    if (_sort == HistorySort.newest) {
      filtered.sort((a, b) {
        final DateTime aDate = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final DateTime bDate = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Asosiy orqa fon uchun gradient ranglar
    final gradientColors = [Colors.blue.shade700, Colors.purple.shade700];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Book Summary', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    color: Colors.white.withOpacity(0.9), // Card uchun yorqin oq rang, biroz shaffof
                    elevation: 6,
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
                            decoration: InputDecoration(
                              labelText: 'Book title',
                              hintText: 'e.g. Atomic Habits',
                              prefixIcon: const Icon(Icons.menu_book_rounded, color: Colors.blueGrey),
                              filled: true,
                              fillColor: Colors.blueGrey.shade50, // Input orqa fon
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _authorCtrl,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'Author (optional)',
                              hintText: 'e.g. James Clear',
                              prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                              filled: true,
                              fillColor: Colors.blueGrey.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: c.isLoading.value ? null : _summarize,
                                icon: c.isLoading.value
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.auto_awesome, color: Colors.white),
                                label: Text(
                                  c.isLoading.value ? 'Summarizing...' : 'Summarize',
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple.shade400, // Tugma rangi
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search, color: Colors.blueGrey),
                            hintText: 'Search by title, author, or text',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9), // Search uchun yorqin oq rang
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            isDense: true,
                          ),
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 12),
                      PopupMenuButton<HistorySort>(
                        tooltip: 'Sort',
                        onSelected: (v) => setState(() => _sort = v),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: HistorySort.newest,
                            child: ListTile(
                              leading: const Icon(Icons.schedule, color: Colors.deepPurple),
                              title: Text(
                                'Newest',
                                style: TextStyle(color: Colors.deepPurple.shade700),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: HistorySort.rating,
                            child: ListTile(
                              leading: const Icon(Icons.star, color: Colors.amber),
                              title: Text(
                                'Highest rating',
                                style: TextStyle(color: Colors.amber.shade700),
                              ),
                            ),
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.deepPurple.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _sort == HistorySort.rating ? Icons.star : Icons.schedule,
                                size: 20,
                                color: _sort == HistorySort.rating ? Colors.amber : Colors.deepPurple,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _sort == HistorySort.rating ? 'Rating' : 'Newest',
                                style: TextStyle(
                                  color: _sort == HistorySort.rating ? Colors.amber.shade700 : Colors.deepPurple.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(Icons.expand_more, size: 18, color: Colors.deepPurple),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (c.summaries.isEmpty) {
                      return _EmptyState(theme: theme);
                    }

                    final items = _filtered();
                    if (items.isEmpty) {
                      return const Center(child: Text('No results found'));
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final e = items[i];

                        final String title = (e.title ?? '').toString();
                        final String author = (e.author ?? '').toString();
                        final String summary = (e.summary ?? '').toString();
                        final int rating = int.tryParse('${e.rating}') ?? 0;
                        final DateTime createdAt =
                            e.createdAt ?? DateTime.now();

                        return _HistoryTile(
                          title: title,
                          author: author,
                          summary: summary,
                          rating: rating.clamp(0, 5),
                          createdAt: createdAt,
                          onShare: () {
                            final text =
                                '$title${author.isNotEmpty ? " — $author" : ""}\n'
                                'Rating: ${"★" * rating}\n\n$summary';
                            Get.snackbar(
                              'Copied',
                              'Share logic here',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
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
          const Icon(Icons.menu_book_outlined, size: 64, color: Colors.white70),
          const SizedBox(height: 12),
          Text(
            'Enter a book to get a summary',
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Add an author for better accuracy',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _HistoryTile extends StatefulWidget {
  const _HistoryTile({
    required this.title,
    required this.author,
    required this.summary,
    required this.rating,
    required this.createdAt,
    required this.onShare,
    Key? key,
  }) : super(key: key);

  final String title;
  final String author;
  final String summary;
  final int rating;
  final DateTime createdAt;
  final VoidCallback onShare;

  @override
  State<_HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<_HistoryTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat.yMMMd().add_jm().format(widget.createdAt);

    return Material(
      color: Colors.white.withOpacity(0.95), // Card uchun oq, ochiq rang
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.deepPurple.shade50,
              ),
              child: Image.network(
                "https://image.pollinations.ai/prompt/${widget.summary}",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.book, size: 28, color: Colors.deepPurple),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title.isEmpty ? 'Untitled' : widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.deepPurple.shade800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onShare,
                        icon: Icon(Icons.ios_share_rounded, size: 20, color: Colors.deepPurple.shade700),
                        tooltip: 'Share',
                      ),
                    ],
                  ),
                  if (widget.author.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        widget.author,
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.deepPurple.shade600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  Text(
                    formattedDate,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.deepPurple.shade400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < widget.rating ? Icons.star_rounded : Icons.star_border_rounded,
                        size: 18,
                        color: i < widget.rating ? Colors.amber.shade700 : Colors.deepPurple.shade200,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Text(
                      widget.summary,
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.deepPurple.shade900),
                      maxLines: _isExpanded ? null : 3,
                      overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Text(
                      _isExpanded ? 'Show less' : 'Read more',
                      style: TextStyle(
                        color: Colors.deepPurple.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
