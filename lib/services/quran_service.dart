import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/surah_model.dart';

class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';
  static const Duration timeout = Duration(seconds: 10);

  /// Fetch all Surahs with error handling
  static Future<List<Surah>> getAllSurahs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> surahs = data['data'] ?? [];
        return surahs.map((surah) => Surah.fromJson(surah)).toList();
      } else {
        throw Exception('فشل تحميل السور: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Fetch specific Surah with Ayahs
  static Future<Map<String, dynamic>> getSurahWithAyahs(int surahNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('فشل تحميل السورة: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Fetch Surah with specific edition (Arabic text)
  static Future<Map<String, dynamic>> getSurahWithEdition(
    int surahNumber,
    String edition,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/$edition'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('فشل تحميل السورة: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Fetch available editions
  static Future<List<Map<String, dynamic>>> getEditions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/edition'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> editions = data['data'] ?? [];
        return editions.cast<Map<String, dynamic>>();
      } else {
        throw Exception('فشل تحميل الإصدارات: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Fetch audio recitation links
  static Future<Map<String, dynamic>> getRecitation(
    int surahNumber,
    String reciter,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/$reciter'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('فشل تحميل التلاوة: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Fetch Tafseer (Explanation)
  static Future<Map<String, dynamic>> getTafseer(
    int surahNumber,
    int ayahNumber,
    String tafseerName,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ayah/$surahNumber:$ayahNumber/$tafseerName'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('فشل تحميل التفسير: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Fetch Juz (Part)
  static Future<Map<String, dynamic>> getJuz(int juzNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/juz/$juzNumber'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('فشل تحميل الجزء: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  /// Get Surah metadata
  static Future<Map<String, dynamic>> getSurahMetadata(
    int surahNumber,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/en.asad'),
      ).timeout(timeout);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('فشل تحميل البيانات الوصفية: رمز الخطأ ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    } on TimeoutException catch (e) {
      throw Exception('انتهت مهلة الانتظار: $e');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }
}
