import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../themes/app_themes.dart';

class AudioPlayerScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const AudioPlayerScreen({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  String _selectedReciter = 'ar.alafasy';

  final Map<String, String> _reciters = {
    'ar.alafasy': 'مشاري العفاسي',
    'ar.abdulbasit': 'عبد الباسط عبد الصمد',
    'ar.minshawi': 'محمود خليل الحصري',
    'ar.husary': 'الحصري',
    'ar.paran': 'عبد الرحمن السديس',
  };

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioPlayer();
    _loadAudio();
  }

  void _setupAudioPlayer() {
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      setState(() {
        _isPlaying = playerState.playing;
      });
    });
  }

  Future<void> _loadAudio() async {
    try {
      final audioUrl =
          'https://cdn.islamic.network/quran/audio/128/ar.alafasy/${widget.surahNumber}.mp3';
      await _audioPlayer.setUrl(audioUrl);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل الصوت: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _changeReciter(String reciter) async {
    setState(() {
      _selectedReciter = reciter;
    });

    try {
      final audioUrl =
          'https://cdn.islamic.network/quran/audio/128/$reciter/${widget.surahNumber}.mp3';
      await _audioPlayer.setUrl(audioUrl);
      await _audioPlayer.play();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل الصوت: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تلاوة سورة ${widget.surahName}'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
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
                    'الرقم: ${widget.surahNumber}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'اختر القارئ',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _reciters.entries.map((entry) {
                final isSelected = _selectedReciter == entry.key;
                return ChoiceChip(
                  label: Text(entry.value),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      _changeReciter(entry.key);
                    }
                  },
                  selectedColor: AppThemes.primaryColor,
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppThemes.primaryColor,
                    inactiveTrackColor:
                        AppThemes.primaryColor.withValues(alpha: 0.2),
                    thumbColor: AppThemes.secondaryColor,
                    overlayColor: AppThemes.secondaryColor.withValues(alpha: 0.3),
                  ),
                  child: Slider(
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_position),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        _formatDuration(_duration),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppThemes.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.stop),
                    color: AppThemes.primaryColor,
                    iconSize: 32,
                    onPressed: () {
                      _audioPlayer.stop();
                    },
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppThemes.primaryColor,
                    border: Border.all(
                      color: AppThemes.secondaryColor,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    iconSize: 48,
                    onPressed: () {
                      if (_isPlaying) {
                        _audioPlayer.pause();
                      } else {
                        _audioPlayer.play();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppThemes.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.repeat),
                    color: AppThemes.primaryColor,
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppThemes.secondaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppThemes.secondaryColor,
                  width: 1.5,
                ),
              ),
              child: Text(
                'يمكنك تشغيل التلاوة واختيار القارئ المفضل لديك من القائمة أعلاه',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
