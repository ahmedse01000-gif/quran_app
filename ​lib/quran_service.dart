import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/surah_model.dart';

class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  // Fetch all Surahs
  static Future<List<Surah>> getAllSurahs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> surahs = data['data'] ?? [];
        return surahs.map((surah) => Surah.fromJson(surah)).toList();
      } else {
        throw Exception('Failed to load Surahs');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch specific Surah with Ayahs
  static Future<Map<String, dynamic>> getSurahWithAyahs(int surahNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('Failed to load Surah');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch Surah with specific edition (Arabic text)
  static Future<Map<String, dynamic>> getSurahWithEdition(
    int surahNumber,
    String edition,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/$edition'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('Failed to load Surah');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch available editions
  static Future<List<Map<String, dynamic>>> getEditions() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/edition'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> editions = data['data'] ?? [];
        return editions.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load editions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch audio recitation links
  static Future<Map<String, dynamic>> getRecitation(
    int surahNumber,
    String reciter,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/$reciter'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('Failed to load recitation');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch Tafseer (Explanation)
  static Future<Map<String, dynamic>> getTafseer(
    int surahNumber,
    int ayahNumber,
    String tafseerName,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ayah/$surahNumber:$ayahNumber/$tafseerName'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('Failed to load Tafseer');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch Juz (Part)
  static Future<Map<String, dynamic>> getJuz(int juzNumber) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/juz/$juzNumber'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('Failed to load Juz');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get Surah metadata
  static Future<Map<String, dynamic>> getSurahMetadata(
    int surahNumber,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/surah/$surahNumber/en.asad'),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? {};
      } else {
        throw Exception('Failed to load metadata');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
