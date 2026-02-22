import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../services/quran_service.dart';
import '../themes.dart';
import 'audio_player_screen.dart';

class ReadingScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const ReadingScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late Future<Map<String, dynamic>> _surahFuture;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _surahFuture =
        QuranService.getSurahWithEdition(widget.surahNumber, 'ar.uthmani');

    // Update current position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranProvider>().updatePosition(widget.surahNumber, 1);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.audio_file),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AudioPlayerScreen(
                    surahNumber: widget.surahNumber,
                    surahName: widget.surahName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _surahFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppThemes.primaryColor,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ في تحميل السورة',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _surahFuture = QuranService.getSurahWithEdition(
                          widget.surahNumber,
                          'ar.uthmani',
                        );
                      });
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('لا توجد بيانات'),
            );
          }

          final surahData = snapshot.data!;
          final ayahs = surahData['ayahs'] ?? [];

          return ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              // Surah Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppThemes.secondaryColor,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'سورة ${widget.surahName}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${ayahs.length} آية',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bismillah
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppThemes.secondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppThemes.secondaryColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppThemes.primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // Ayahs
              ...List.generate(
                ayahs.length,
                (index) {
                  final ayah = ayahs[index];
                  final ayahNumber = ayah['numberInSurah'] ?? index + 1;
                  final ayahText = ayah['text'] ?? '';

                  return AyahWidget(
                    surahNumber: widget.surahNumber,
                    ayahNumber: ayahNumber,
                    ayahText: ayahText,
                    index: index,
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }
}

class AyahWidget extends StatelessWidget {
  final int surahNumber;
  final int ayahNumber;
  final String ayahText;
  final int index;

  const AyahWidget({
    super.key,
    required this.surahNumber,
    required this.ayahNumber,
    required this.ayahText,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = context.watch<BookmarkProvider>();
    final isBookmarked =
        bookmarkProvider.isBookmarked(surahNumber, ayahNumber);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppThemes.primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ayah Text
          Text(
            ayahText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  height: 2,
                ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 12),

          // Ayah Number and Bookmark Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '[$ayahNumber]',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: AppThemes.secondaryColor,
                  size: 24,
                ),
                onPressed: () {
                  if (isBookmarked) {
                    final index = bookmarkProvider.bookmarks.indexWhere(
                      (b) =>
                          b['surahNumber'] == surahNumber &&
                          b['ayahNumber'] == ayahNumber,
                    );
                    if (index != -1) {
                      bookmarkProvider.removeBookmark(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم حذف الإشارة المرجعية'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  } else {
                    bookmarkProvider.addBookmark(
                      surahNumber,
                      'سورة',
                      ayahNumber,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إضافة الإشارة المرجعية'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
