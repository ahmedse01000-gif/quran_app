import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../themes.dart';
import 'reading_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  String _formatDate(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inHours < 1) {
      return 'قبل ${difference.inMinutes} دقيقة';
    } else if (difference.inDays < 1) {
      return 'قبل ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'قبل ${difference.inDays} أيام';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشارات المرجعية'),
        elevation: 2,
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, _) {
          final bookmarks = bookmarkProvider.bookmarks;

          if (bookmarks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 64,
                    color: AppThemes.primaryColor.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد إشارات مرجعية',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'أضف إشارات مرجعية أثناء قراءة القرآن',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarks[index];
              final surahNumber = bookmark['surahNumber'] as int;
              final surahName = bookmark['surahName'] as String;
              final ayahNumber = bookmark['ayahNumber'] as int;
              final timestamp = bookmark['timestamp'] as int;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                elevation: 2,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppThemes.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppThemes.secondaryColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        surahNumber.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    'سورة $surahName - الآية $ayahNumber',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    _formatDate(timestamp),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text('فتح'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ReadingScreen(
                                surahNumber: surahNumber,
                                surahName: surahName,
                              ),
                            ),
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: const Text('حذف'),
                        onTap: () {
                          bookmarkProvider.removeBookmark(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم حذف الإشارة المرجعية'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReadingScreen(
                          surahNumber: surahNumber,
                          surahName: surahName,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
