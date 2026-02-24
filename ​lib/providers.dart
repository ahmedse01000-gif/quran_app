import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  late SharedPreferences _prefs;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setTheme(bool isDark) async {
    _isDarkMode = isDark;
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}

class BookmarkProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _bookmarks = [];
  late SharedPreferences _prefs;

  List<Map<String, dynamic>> get bookmarks => _bookmarks;

  BookmarkProvider() {
    _initializeBookmarks();
  }

  Future<void> _initializeBookmarks() async {
    _prefs = await SharedPreferences.getInstance();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    final bookmarkStrings = _prefs.getStringList('bookmarks') ?? [];
    _bookmarks = bookmarkStrings.map((json) {
      final parts = json.split('|');
      return {
        'surahNumber': int.parse(parts[0]),
        'surahName': parts[1],
        'ayahNumber': int.parse(parts[2]),
        'timestamp': int.parse(parts[3]),
      };
    }).toList();
  }

  Future<void> addBookmark(
    int surahNumber,
    String surahName,
    int ayahNumber,
  ) async {
    _bookmarks.add({
      'surahNumber': surahNumber,
      'surahName': surahName,
      'ayahNumber': ayahNumber,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
    await _saveBookmarks();
    notifyListeners();
  }

  Future<void> removeBookmark(int index) async {
    _bookmarks.removeAt(index);
    await _saveBookmarks();
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    final bookmarkStrings = _bookmarks.map((bookmark) {
      return '${bookmark['surahNumber']}|${bookmark['surahName']}|${bookmark['ayahNumber']}|${bookmark['timestamp']}';
    }).toList();
    await _prefs.setStringList('bookmarks', bookmarkStrings);
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

  int get currentSurah => _currentSurah;
  int get currentAyah => _currentAyah;

  QuranProvider() {
    _initializePosition();
  }

  Future<void> _initializePosition() async {
    _prefs = await SharedPreferences.getInstance();
    _currentSurah = _prefs.getInt('currentSurah') ?? 1;
    _currentAyah = _prefs.getInt('currentAyah') ?? 1;
    notifyListeners();
  }

  Future<void> updatePosition(int surah, int ayah) async {
    _currentSurah = surah;
    _currentAyah = ayah;
    await _prefs.setInt('currentSurah', surah);
    await _prefs.setInt('currentAyah', ayah);
    notifyListeners();
  }
}
