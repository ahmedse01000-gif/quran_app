import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_providers.dart';
import '../themes/app_themes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المظهر',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Icon(
                            themeProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: AppThemes.primaryColor,
                            size: 28,
                          ),
                          title: Text(
                            'الوضع الليلي',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Text(
                            themeProvider.isDarkMode ? 'مفعل' : 'معطل',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme();
                            },
                            activeThumbColor: AppThemes.primaryColor,
                            activeTrackColor:
                                AppThemes.primaryColor.withValues(alpha: 0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حجم الخط',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'صغير',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                'كبير',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Slider(
                            value: 18,
                            min: 14,
                            max: 28,
                            divisions: 7,
                            onChanged: (value) {},
                            activeColor: AppThemes.primaryColor,
                            inactiveColor:
                                AppThemes.primaryColor.withValues(alpha: 0.2),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'معاينة: هذا هو حجم الخط الحالي',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'العرض',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(Icons.line_weight),
                      title: Text(
                        'ارتفاع السطر',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: DropdownButton<String>(
                        value: 'عادي',
                        items: const [
                          DropdownMenuItem(
                            value: 'ضيق',
                            child: Text('ضيق'),
                          ),
                          DropdownMenuItem(
                            value: 'عادي',
                            child: Text('عادي'),
                          ),
                          DropdownMenuItem(
                            value: 'واسع',
                            child: Text('واسع'),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(Icons.text_fields),
                      title: Text(
                        'محاذاة النص',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: DropdownButton<String>(
                        value: 'يمين',
                        items: const [
                          DropdownMenuItem(
                            value: 'يمين',
                            child: Text('يمين'),
                          ),
                          DropdownMenuItem(
                            value: 'وسط',
                            child: Text('وسط'),
                          ),
                          DropdownMenuItem(
                            value: 'يسار',
                            child: Text('يسار'),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'حول التطبيق',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(Icons.info),
                      title: Text(
                        'الإصدار',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      trailing: Text(
                        '1.0.0',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(Icons.source),
                      title: Text(
                        'مصدر البيانات',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        'API القرآن الكريم',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppThemes.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'تطبيق القرآن الكريم',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'تطبيق متكامل لقراءة وسماع القرآن الكريم',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'صُنع بكل محبة وإخلاص',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
