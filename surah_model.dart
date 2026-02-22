class Surah {
  final int number;
  final String name;
  final String nameArabic;
  final String nameEnglish;
  final int numberOfAyahs;
  final String revelationType;
  final List<String> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.nameArabic,
    required this.nameEnglish,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      nameArabic: json['name'] ?? '',
      nameEnglish: json['englishName'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      revelationType: json['revelationType'] ?? '',
      ayahs: [],
    );
  }
}

class Ayah {
  final int number;
  final String text;
  final int surahNumber;
  final int numberInSurah;

  Ayah({
    required this.number,
    required this.text,
    required this.surahNumber,
    required this.numberInSurah,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      surahNumber: json['surah']['number'] ?? 0,
      numberInSurah: json['numberInSurah'] ?? 0,
    );
  }
}
