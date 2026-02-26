import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  bool get isDarkMode => _isDarkMode;
  bool get isInitialized => _isInitialized;

  ThemeProvider() {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تهيئة المظهر: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    try {
      _isDarkMode = !_isDarkMode;
      await _prefs.setBool('isDarkMode', _isDarkMode);
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تبديل المظهر: $e');
    }
  }

  Future<void> setTheme(bool isDark) async {
    try {
      _isDarkMode = isDark;
      await _prefs.setBool('isDarkMode', _isDarkMode);
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تعيين المظهر: $e');
    }
  }
}

class BookmarkProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _bookmarks = [];
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  List<Map<String, dynamic>> get bookmarks => _bookmarks;
  bool get isInitialized => _isInitialized;

  BookmarkProvider() {
    _initializeBookmarks();
  }

  Future<void> _initializeBookmarks() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _loadBookmarks();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تهيئة الإشارات المرجعية: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }

  void _loadBookmarks() {
    try {
      final bookmarkStrings = _prefs.getStringList('bookmarks') ?? [];
      _bookmarks = bookmarkStrings.map((json) {
        try {
          final parts = json.split('|');
          if (parts.length < 4) {
            return null;
          }
          return {
            'surahNumber': int.parse(parts[0]),
            'surahName': parts[1],
            'ayahNumber': int.parse(parts[2]),
            'timestamp': int.parse(parts[3]),
          };
        } catch (e) {
          debugPrint('خطأ في تحليل الإشارة المرجعية: $e');
          return null;
        }
      }).whereType<Map<String, dynamic>>().toList();
    } catch (e) {
      debugPrint('خطأ في تحميل الإشارات المرجعية: $e');
      _bookmarks = [];
    }
  }

  Future<void> addBookmark(
    int surahNumber,
    String surahName,
    int ayahNumber,
  ) async {
    try {
      _bookmarks.add({
        'surahNumber': surahNumber,
        'surahName': surahName,
        'ayahNumber': ayahNumber,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      await _saveBookmarks();
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في إضافة الإشارة المرجعية: $e');
    }
  }

  Future<void> removeBookmark(int index) async {
    try {
      if (index >= 0 && index < _bookmarks.length) {
        _bookmarks.removeAt(index);
        await _saveBookmarks();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('خطأ في حذف الإشارة المرجعية: $e');
    }
  }

  Future<void> _saveBookmarks() async {
    try {
      final bookmarkStrings = _bookmarks.map((bookmark) {
        return '${bookmark['surahNumber']}|${bookmark['surahName']}|${bookmark['ayahNumber']}|${bookmark['timestamp']}';
      }).toList();
      await _prefs.setStringList('bookmarks', bookmarkStrings);
    } catch (e) {
      debugPrint('خطأ في حفظ الإشارات المرجعية: $e');
    }
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    return _bookmarks.any((bookmark) =>
        bookmark['surahNumber'] == surahNumber &&
        bookmark['ayahNumber'] == ayahNumber);
  }
}

class QuranProvider extends ChangeNotifier {
  int _currentSurah = 1;
  int _currentAyah = 1;
  late SharedPreferences _prefs;
  bool _isInitialized = false;

  int get currentSurah => _currentSurah;
  int get currentAyah => _currentAyah;
  bool get isInitialized => _isInitialized;

  QuranProvider() {
    _initializePosition();
  }

  Future<void> _initializePosition() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _currentSurah = _prefs.getInt('currentSurah') ?? 1;
      _currentAyah = _prefs.getInt('currentAyah') ?? 1;
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تهيئة الموضع: $e');
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> updatePosition(int surah, int ayah) async {
    try {
      _currentSurah = surah;
      _currentAyah = ayah;
      await _prefs.setInt('currentSurah', surah);
      await _prefs.setInt('currentAyah', ayah);
      notifyListeners();
    } catch (e) {
      debugPrint('خطأ في تحديث الموضع: $e');
    }
  }
}
