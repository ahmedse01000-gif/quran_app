# دليل إعداد Codemagic للبناء التلقائي

## 📋 المتطلبات

- حساب على [Codemagic](https://codemagic.io)
- مستودع GitHub متصل
- ملف `codemagic.yaml` في جذر المشروع (✅ موجود بالفعل)

## 🚀 خطوات الإعداد

### 1. تسجيل الدخول إلى Codemagic

1. اذهب إلى [Codemagic](https://codemagic.io)
2. انقر على **Sign in with GitHub**
3. وافق على الصلاحيات المطلوبة

### 2. ربط المستودع

1. في لوحة التحكم، انقر على **+ Add application**
2. اختر **GitHub** كمصدر الكود
3. ابحث عن مستودع `quran_app`
4. انقر على **Next**

### 3. تحديد Workflow

1. ستظهر لك الخيارات التالية:
   - **Android Release Build** - للبناء النهائي (APK و AAB)
   - **Android Debug Build** - للاختبار والتطوير

2. اختر **Android Release Build** للبناء النهائي
3. انقر على **Next**

### 4. إعدادات البناء

#### متغيرات البيئة (اختياري):

إذا أردت إضافة متغيرات بيئة:

1. انقر على **Environment variables**
2. أضف المتغيرات التالية:
   ```
   DEVELOPER_EMAIL = your-email@example.com
   ```

#### توقيع APK (مهم للنشر):

إذا كنت تريد نشر التطبيق على Google Play:

1. انقر على **Android signing**
2. اختر **Create a new keystore**
3. ملأ البيانات التالية:
   ```
   Keystore password: [كلمة مرور قوية]
   Key password: [كلمة مرور قوية]
   Key alias: quran_app
   Organization: [اسم شركتك/اسمك]
   ```
4. انقر على **Save**

### 5. تفعيل البناء التلقائي

1. في قسم **Triggering**:
   - ✅ **Push** - بناء تلقائي عند كل push
   - ✅ **Tag** - بناء تلقائي عند إنشاء tag جديد

2. اختر الفروع:
   - `main` - للبناء النهائي
   - `develop` - للبناء التجريبي

### 6. إشعارات البناء

1. انقر على **Notifications**
2. اختر القنوات المفضلة:
   - **Email** - إرسال بريد عند نجاح/فشل البناء
   - **Slack** - إرسال رسالة إلى قناة Slack (اختياري)

### 7. حفظ والبدء

1. انقر على **Save**
2. سيبدأ البناء الأول تلقائياً
3. يمكنك متابعة التقدم في لوحة التحكم

## 📊 مراقبة البناء

### عرض سجلات البناء:

1. اذهب إلى **Builds**
2. اختر أحدث بناء
3. اعرض التفاصيل والسجلات

### تحميل الـ APK:

1. بعد نجاح البناء، انقر على **Artifacts**
2. حمل ملف APK أو AAB

## 🔄 البناء اليدوي

إذا أردت بناء يدوي بدون انتظار push:

1. اذهب إلى **Builds**
2. انقر على **Start new build**
3. اختر الفرع والإعدادات
4. انقر على **Build**

## 🐛 استكشاف الأخطاء

### البناء فشل؟

1. **تحقق من السجلات**:
   - اذهب إلى **Builds** → اختر البناء الفاشل
   - اقرأ رسالة الخطأ بعناية

2. **الأخطاء الشائعة**:
   - **Flutter not found**: تأكد من وجود Flutter SDK
   - **Gradle error**: تحقق من `pubspec.yaml` و `build.gradle`
   - **Signing error**: تحقق من بيانات التوقيع

3. **حل المشاكل**:
   - اختبر البناء محلياً أولاً: `flutter build apk --release`
   - تأكد من أن جميع التبعيات مثبتة: `flutter pub get`
   - تحقق من ملف `codemagic.yaml`

## 📝 ملف codemagic.yaml

ملف التكوين موجود بالفعل في المشروع ويحتوي على:

### Workflows المتاحة:

#### 1. Android Release Build
```yaml
- البناء على: Mac Mini M1
- المدة القصوى: 120 دقيقة
- التفعيل: عند push على main أو develop
- المخرجات: APK و AAB
```

#### 2. Android Debug Build
```yaml
- البناء على: Mac Mini M1
- المدة القصوى: 60 دقيقة
- التفعيل: عند pull request على develop
- المخرجات: APK Debug
```

## 🎯 أفضل الممارسات

1. **استخدم Semantic Versioning**:
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

2. **اختبر محلياً أولاً**:
   ```bash
   flutter test
   flutter build apk --release
   ```

3. **راقب السجلات**:
   - تحقق من سجلات البناء بانتظام
   - احتفظ بسجل للبناءات الناجحة والفاشلة

4. **استخدم متغيرات البيئة**:
   - لا تضع كلمات مرور في الكود
   - استخدم متغيرات البيئة في Codemagic

## 🔐 الأمان

1. **لا تشارك الـ Token**:
   - الـ GitHub token حساس جداً
   - لا تضعه في الكود أو السجلات

2. **استخدم Secrets**:
   - في Codemagic، استخدم **Secure environment variables**
   - لا تعرض كلمات المرور في السجلات

3. **حماية المستودع**:
   - استخدم branch protection rules
   - اطلب code review قبل merge

## 📞 الدعم

- **Codemagic Documentation**: https://docs.codemagic.io
- **Flutter Documentation**: https://flutter.dev/docs
- **GitHub Actions**: https://docs.github.com/en/actions

## ✅ قائمة التحقق

- [ ] حساب Codemagic مُنشأ
- [ ] المستودع مرتبط مع Codemagic
- [ ] ملف `codemagic.yaml` موجود
- [ ] متغيرات البيئة مُعدّة
- [ ] توقيع APK مُعدّ (إن لزم)
- [ ] الإشعارات مُفعّلة
- [ ] أول بناء نجح بنجاح
- [ ] APK تم تحميله بنجاح

---

**آخر تحديث**: 2026-02-25

**الحالة**: ✅ جاهز للبناء التلقائي
