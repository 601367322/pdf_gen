import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar', 'zh_Hans', 'zh_Hant'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
    String? zh_HansText = '',
    String? zh_HantText = '',
  }) =>
      [enText, arText, zh_HansText, zh_HantText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // loginPage
  {
    'z2h8w11t': {
      'en': 'B-Wallet',
      'ar': 'محفظة NXTT',
      'zh_Hans': 'B-Wallet',
      'zh_Hant': 'NXTT錢包',
    },
    'o07j3mgv': {
      'en': 'Welcome back',
      'ar': 'مرحبًا بعودتك',
      'zh_Hans': '欢迎回来',
      'zh_Hant': '歡迎回來',
    },
    'fzxvw3mu': {
      'en': 'Login to access your account below.',
      'ar': 'قم بتسجيل الدخول للوصول إلى حسابك أدناه.',
      'zh_Hans': '登录后即可访问下面您的帐户。',
      'zh_Hant': '登入以存取您的以下帳戶。',
    },
    'a9j78va9': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'zh_Hans': '电子邮件',
      'zh_Hant': '電子郵件',
    },
    'i7f18cve': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني...',
      'zh_Hans': '输入您的电子邮件...',
      'zh_Hant': '輸入您的電子郵件...',
    },
    'wztjmbn8': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'zh_Hans': '密码',
      'zh_Hant': '密碼',
    },
    'lw1jpm1f': {
      'en': 'Enter your password...',
      'ar': 'أدخل كلمة المرور الخاصة بك...',
      'zh_Hans': '输入您的密码...',
      'zh_Hant': '輸入您的密碼...',
    },
    'm2xyjvuf': {
      'en': 'Forgot Password?',
      'ar': 'هل نسيت كلمة السر؟',
      'zh_Hans': '忘记密码？',
      'zh_Hant': '忘記密碼？',
    },
    'qbmoi1av': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
      'zh_Hans': '登录',
      'zh_Hant': '登入',
    },
    'cjqb8ial': {
      'en': 'Don\'t have an account?',
      'ar': 'ليس لديك حساب؟',
      'zh_Hans': '沒有帳戶？',
      'zh_Hant': '沒有帳戶？',
    },
    'a0iimirx': {
      'en': 'Create',
      'ar': 'يخلق',
      'zh_Hans': '创造',
      'zh_Hant': '創造',
    },
    '2bb3vct7': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // registerAccount
  {
    'gpokmd81': {
      'en': 'Get Started',
      'ar': 'البدء',
      'zh_Hans': '立即开始',
      'zh_Hant': '開始使用',
    },
    'oitrrwgg': {
      'en': 'Create your account below.',
      'ar': 'قم بإنشاء حسابك أدناه.',
      'zh_Hans': '在下面创建您的帐户。',
      'zh_Hant': '在下面建立您的帳戶。',
    },
    'gcwdqm4g': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'zh_Hans': '电子邮件',
      'zh_Hant': '電子郵件',
    },
    'iam0xgwx': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني...',
      'zh_Hans': '输入您的电子邮件...',
      'zh_Hant': '輸入您的電子郵件...',
    },
    'bqv15dcf': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'zh_Hans': '密码',
      'zh_Hant': '密碼',
    },
    'joih97mn': {
      'en': 'Enter your password...',
      'ar': 'أدخل كلمة المرور الخاصة بك...',
      'zh_Hans': '输入您的密码...',
      'zh_Hant': '輸入您的密碼...',
    },
    'rzpiwq9p': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'zh_Hans': '确认密码',
      'zh_Hant': '確認密碼',
    },
    'eyfkffka': {
      'en': 'Enter your password...',
      'ar': 'أدخل كلمة المرور الخاصة بك...',
      'zh_Hans': '输入您的密码...',
      'zh_Hant': '輸入您的密碼...',
    },
    '5kmjfwsk': {
      'en': 'Create Account',
      'ar': 'إنشاء حساب',
      'zh_Hans': '创建账户',
      'zh_Hant': '建立帳戶',
    },
    '3twynvfz': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
      'zh_Hans': '登录',
      'zh_Hant': '登入',
    },
    '9ssznj0g': {
      'en': 'Already have an account?',
      'ar': 'هل لديك حساب بالفعل؟',
      'zh_Hans': '已有账户？',
      'zh_Hant': '已經有帳戶？',
    },
    'momge5oj': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // completeProfile
  {
    'yhcaf7r2': {
      'en': 'Complete Profile',
      'ar': 'الملف الشخصي الكامل',
      'zh_Hans': '完整简介',
      'zh_Hant': '完整的個人資料',
    },
    'r6npjsue': {
      'en': 'Upload a photo for us to easily identify you.',
      'ar': 'قم بتحميل صورة لنا حتى نتمكن من التعرف عليك بسهولة.',
      'zh_Hans': '上传一张照片以便我们轻松识别您。',
      'zh_Hant': '上傳照片以便我們輕鬆識別您的身分。',
    },
    'sdptn7dd': {
      'en': 'Your Name',
      'ar': 'اسمك',
      'zh_Hans': '您的名字',
      'zh_Hant': '你的名字',
    },
    'n636qnrx': {
      'en': 'Your Age',
      'ar': 'عمرك',
      'zh_Hans': '你的年龄',
      'zh_Hant': '你的年齡',
    },
    's7yvjzbs': {
      'en': 'i.e. 34',
      'ar': 'أي 34',
      'zh_Hans': '即 34',
      'zh_Hant': '即 34',
    },
    '72ii0waq': {
      'en': 'Your Title',
      'ar': 'عنوانك',
      'zh_Hans': '你的头衔',
      'zh_Hant': '您的頭銜',
    },
    'pf8glhkg': {
      'en': 'What is your position?',
      'ar': 'ما هو موقفك؟',
      'zh_Hans': '你的立场是什么？',
      'zh_Hant': '你的立場是什麼？',
    },
    'hbhd3bdt': {
      'en': 'Complete Profile',
      'ar': 'الملف الشخصي الكامل',
      'zh_Hans': '完整简介',
      'zh_Hant': '完整的個人資料',
    },
    '1eac148w': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
      'zh_Hans': '必填字段',
      'zh_Hant': '欄位為必填項',
    },
    'ew7dbn3s': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
      'zh_Hans': '必填字段',
      'zh_Hant': '欄位為必填項',
    },
    'jhhlgzk5': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
      'zh_Hans': '必填字段',
      'zh_Hant': '欄位為必填項',
    },
    '4k3jnl38': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // forgotPassword
  {
    'g416xg9f': {
      'en': 'Forgot Password',
      'ar': 'هل نسيت كلمة السر',
      'zh_Hans': '忘记密码',
      'zh_Hant': '忘記密碼',
    },
    'xaiad71o': {
      'en':
          'Enter the email associated with your account and we will send you a verification code.',
      'ar': 'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رمز التحقق.',
      'zh_Hans': '输入与您的帐户关联的电子邮件，我们将向您发送验证码。',
      'zh_Hant': '輸入與您的帳戶關聯的電子郵件，我們將向您發送驗證碼。',
    },
    'u4nuk910': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'zh_Hans': '电子邮件',
      'zh_Hant': '電子郵件',
    },
    '37kotxi0': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني...',
      'zh_Hans': '输入您的电子邮件...',
      'zh_Hant': '輸入您的電子郵件...',
    },
    'hiwpaze1': {
      'en': 'Send Reset Link',
      'ar': 'إرسال رابط إعادة الضبط',
      'zh_Hans': '发送重置链接',
      'zh_Hant': '發送重置連結',
    },
    '598b8d3m': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // onboarding
  {
    'i8hl2uua': {
      'en': 'Create Budgets',
      'ar': 'إنشاء الميزانيات',
      'zh_Hans': '创建预算',
      'zh_Hant': '建立預算',
    },
    'hxtwax0y': {
      'en':
          'Create budgets that you can tie transactions too in order for easy tracking.',
      'ar': 'قم بإنشاء ميزانيات يمكنك ربط المعاملات بها لتسهيل تتبعها.',
      'zh_Hans': '创建可以与交易绑定的预算，以便于跟踪。',
      'zh_Hant': '建立預算，您也可以將其與交易聯繫起來，以便於追蹤。',
    },
    'mjy3ljln': {
      'en': 'Keep Track of Spending',
      'ar': 'تتبع الإنفاق',
      'zh_Hans': '记录支出',
      'zh_Hant': '追蹤支出',
    },
    'uf9k1spp': {
      'en':
          'Easily add transactions and associate them with budgets that have been created.',
      'ar': 'يمكنك بسهولة إضافة المعاملات وربطها بالميزانيات التي تم إنشاؤها.',
      'zh_Hans': '轻松添加交易并将其与已创建的预算关联。',
      'zh_Hant': '輕鬆新增交易並將其與已建立的預算相關聯。',
    },
    '9c4outzf': {
      'en': 'Budget Analysis',
      'ar': 'تحليل الميزانية',
      'zh_Hans': '预算分析',
      'zh_Hant': '預算分析',
    },
    'q30ina4f': {
      'en': 'Know where your budgets are and how they can be adjusted.',
      'ar': 'تعرف على مكان ميزانيتك وكيف يمكن تعديلها.',
      'zh_Hans': '了解您的预算在哪里以及如何调整预算。',
      'zh_Hant': '了解您的預算在哪裡以及如何調整它們。',
    },
    'ypt7b97g': {
      'en': 'Create Your Budget',
      'ar': 'إنشاء الميزانية الخاصة بك',
      'zh_Hans': '创建您的预算',
      'zh_Hant': '制定您的預算',
    },
    'oo0kk9qe': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // createBudgetBegin
  {
    'xod9iwab': {
      'en': 'Create Budget',
      'ar': 'إنشاء الميزانية',
      'zh_Hans': '创建预算',
      'zh_Hant': '建立預算',
    },
    'wih71x51': {
      'en': 'Amount',
      'ar': 'كمية',
      'zh_Hans': '数量',
      'zh_Hant': '數量',
    },
    'qk15nsmc': {
      'en': 'Budget Name',
      'ar': 'اسم الميزانية',
      'zh_Hans': '预算名称',
      'zh_Hant': '預算名稱',
    },
    'iphvcuwc': {
      'en': 'Description',
      'ar': 'وصف',
      'zh_Hans': '描述',
      'zh_Hant': '描述',
    },
    'v2shqq3z': {
      'en': 'Create Budget',
      'ar': 'إنشاء الميزانية',
      'zh_Hans': '创建预算',
      'zh_Hant': '建立預算',
    },
    'knu0nxbp': {
      'en': 'Tap above to complete request',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'zh_Hans': '点按上方以完成请求',
      'zh_Hant': '點擊上方即可完成請求',
    },
    '79au6dyg': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    'cs1cy7tg': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // MY_Card
  {
    'r5mvnlaa': {
      'en': 'Wallet Balance',
      'ar': 'رصيد المحفظة',
      'zh_Hans': '钱包余额',
      'zh_Hant': '錢包餘額',
    },
    'nq471rke': {
      'en': '≈\$313,354,824.78',
      'ar': '313,354,824.78 دولار',
      'zh_Hans': '\$313,354,824.78',
      'zh_Hant': '\$313,354,824.78',
    },
    'mwyxhlyf': {
      'en': '4 currencies',
      'ar': '3 عملات',
      'zh_Hans': '4 种货币',
      'zh_Hant': '4種貨幣',
    },
    'wom3n7zb': {
      'en': 'BTC (5167.00)',
      'ar': 'بيتكوين (5167.00)',
      'zh_Hans': 'BTC (5167.00)',
      'zh_Hant': 'BTC (5167.00)',
    },
    '3gy2tpo4': {
      'en': '≈\$310,624,539.43',
      'ar': 'حوالي 310,624,539.43 دولار',
      'zh_Hans': '≈\$310,624,539.43',
      'zh_Hant': '≈\$310,624,539.43',
    },
    'wwgeorvg': {
      'en': '99.13% >>',
      'ar': '99.13% >>',
      'zh_Hans': '99.13% >>',
      'zh_Hant': '99.13%>>',
    },
    '9gqacxls': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'wcw6o7pv': {
      'en': 'ETH (0.00)',
      'ar': 'إيثريوم (0.00)',
      'zh_Hans': 'ETH（0.00）',
      'zh_Hant': 'ETH (0.00)',
    },
    'i76i75h5': {
      'en': '≈\$0.00',
      'ar': '≈0.00 دولار',
      'zh_Hans': '≈\$0.00',
      'zh_Hant': '≈\$0.00',
    },
    'r4rod5ll': {
      'en': '0.00% >>',
      'ar': '0.00% >>',
      'zh_Hans': '0.00% >>',
      'zh_Hant': '0.00%>>',
    },
    'olsewk5q': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'pacm7vyb': {
      'en': 'FGOLD (0.00)',
      'ar': 'فجولد (0.00)',
      'zh_Hans': 'FGOLD (0.00)',
      'zh_Hant': 'FGOLD (0.00)',
    },
    '14p7r0ko': {
      'en': '≈\$0.00',
      'ar': '≈0.00 دولار',
      'zh_Hans': '≈\$0.00',
      'zh_Hant': '≈\$0.00',
    },
    'yzypdycw': {
      'en': '0.00% >>',
      'ar': '0.00% >>',
      'zh_Hans': '0.00% >>',
      'zh_Hant': '0.00%>>',
    },
    'zfjlri1j': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'v2lxypw4': {
      'en': 'USDT(OMNI) (2,730,285)',
      'ar': 'USDT(OMNI) (2,730,285)',
      'zh_Hans': 'USDT(OMNI) (2,730,285）',
      'zh_Hant': 'USDT(OMNI) (2,730,285)',
    },
    '59ps06z3': {
      'en': '≈\$2,730,285.35',
      'ar': 'حوالي 2,730,285.35 دولار',
      'zh_Hans': '≈\$2,730,285.35',
      'zh_Hant': '≈\$2,730,285.35',
    },
    'umqxwcm5': {
      'en': '0.87% >>',
      'ar': '0.87% >>',
      'zh_Hans': '0.87% >>',
      'zh_Hant': '0.87%>>',
    },
    'l2cndxsg': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'm8rhanhc': {
      'en': '•',
      'ar': '•',
      'zh_Hans': '•',
      'zh_Hant': '•',
    },
  },
  // CoinCap
  {
    '2y5ahe19': {
      'en': 'CoinCap',
      'ar': 'كوينكاب',
      'zh_Hans': 'CoinCap',
      'zh_Hant': 'CionCap',
    },
    'ofz2zvlc': {
      'en': '•',
      'ar': '•',
      'zh_Hans': '•',
      'zh_Hant': '•',
    },
  },
  // paymentDetails
  {
    'j0yzgf4n': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'zh_Hans': '细节',
      'zh_Hant': '細節',
    },
    'zv72ekdw': {
      'en': 'Amount',
      'ar': 'كمية',
      'zh_Hans': '数量',
      'zh_Hant': '數量',
    },
    '0rjyjwed': {
      'en': 'Vendor',
      'ar': 'بائع',
      'zh_Hans': '小贩',
      'zh_Hant': '小販',
    },
    'eeyn6dk2': {
      'en': 'When',
      'ar': 'متى',
      'zh_Hans': '什么时候',
      'zh_Hant': '什麼時候',
    },
    'lccxx6eu': {
      'en': 'Reason',
      'ar': 'سبب',
      'zh_Hans': '原因',
      'zh_Hant': '原因',
    },
    'jzyax4hn': {
      'en': 'Spent by',
      'ar': 'تم إنفاقه بواسطة',
      'zh_Hans': '花费',
      'zh_Hant': '花費者',
    },
    'i4r9jqwn': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // MY_profilePage
  {
    'f1bvbey3': {
      'en': 'My Account',
      'ar': 'حسابي',
      'zh_Hans': '我的账户',
      'zh_Hant': '我的帳戶',
    },
    'i61y9ibx': {
      'en': 'Edit Profile',
      'ar': 'تعديل الملف الشخصي',
      'zh_Hans': '編輯資料',
      'zh_Hant': '編輯個人資料',
    },
    'language': {
      'en': 'Language',
      'ar': 'اللغة',
      'zh_Hans': '语言',
      'zh_Hant': '語言',
    },
    'download statement': {
      'en': 'Download Statement',
      'ar': 'تحميل البيان',
      'zh_Hans': '下载对账单',
      'zh_Hant': '下載對賬單',
    },
    '03k0vw86': {
      'en': 'Change Password',
      'ar': 'تغيير كلمة المرور',
      'zh_Hans': '更改密码',
      'zh_Hant': '更改密碼',
    },
    '6w6wv95p': {
      'en': 'Notification Settings',
      'ar': 'إعدادات الإشعارات',
      'zh_Hans': '通知设置',
      'zh_Hant': '通知設定',
    },
    'eojlfs66': {
      'en': 'Privacy Policy',
      'ar': 'سياسة الخصوصية',
      'zh_Hans': '隐私政策',
      'zh_Hant': '隱私權政策',
    },
    '2ll42t1u': {
      'en': 'Dark Mode',
      'ar': 'الوضع المظلم',
      'zh_Hans': '深色模式',
      'zh_Hant': '深色模式',
    },
    '8d386226': {
      'en': 'Light Mode',
      'ar': 'وضع الضوء',
      'zh_Hans': '灯光模式',
      'zh_Hant': '燈光模式',
    },
    '8srr2k0j': {
      'en': '•',
      'ar': '•',
      'zh_Hans': '•',
      'zh_Hant': '•',
    },
  },
  // budgetDetails
  {
    'p0gf1lfy': {
      'en': 'Per Month',
      'ar': 'كل شهر',
      'zh_Hans': '每月',
      'zh_Hant': '每月',
    },
    'ti7ipegi': {
      'en': 'Total Spent',
      'ar': 'إجمالي الإنفاق',
      'zh_Hans': '总花费',
      'zh_Hant': '總花費',
    },
    'ifi6fmsa': {
      'en': 'Transactions',
      'ar': 'المعاملات',
      'zh_Hans': '交易',
      'zh_Hant': '交易',
    },
    'ak9m8szp': {
      'en': 'Income',
      'ar': 'دخل',
      'zh_Hans': '收入',
      'zh_Hant': '收入',
    },
    'l53kroui': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // transferComplete
  {
    'xf8d4sm8': {
      'en': 'Transfer Complete',
      'ar': 'تم النقل بالكامل',
      'zh_Hans': '传输完成',
      'zh_Hant': '轉移完成',
    },
    'iq9jjji8': {
      'en':
          'Great work, you successfully transferred funds. It may take a few days for the funds to leave your account.',
      'ar':
          'عمل رائع، لقد نجحت في تحويل الأموال. قد يستغرق الأمر بضعة أيام حتى تخرج الأموال من حسابك.',
      'zh_Hans': '太棒了，您已成功转账。资金可能需要几天时间才能转出您的账户。',
      'zh_Hant': '幹得好，您已成功轉帳。資金可能需要幾天才能離開您的帳戶。',
    },
    'wrbg19ed': {
      'en': 'Okay',
      'ar': 'تمام',
      'zh_Hans': '好的',
      'zh_Hant': '好的',
    },
    'ndkybnrt': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // transferFunds
  {
    'pe3o18oh': {
      'en': 'Transfer Funds',
      'ar': 'تحويل الأموال',
      'zh_Hans': '转移资金',
      'zh_Hant': '轉移資金',
    },
    'kyzwrfh4': {
      'en': 'Balance',
      'ar': 'توازن',
      'zh_Hans': '平衡',
      'zh_Hant': '平衡',
    },
    'zq4ozx20': {
      'en': '\$7,630',
      'ar': '7,630 دولار',
      'zh_Hans': '\$7,630',
      'zh_Hant': '7,630 美元',
    },
    'qukh7yo1': {
      'en': '**** 0149',
      'ar': '**** 0149',
      'zh_Hans': '**** 0149',
      'zh_Hant': '****0149',
    },
    'n87hkr7d': {
      'en': '05/25',
      'ar': '25/05',
      'zh_Hans': '05/25',
      'zh_Hant': '05/25',
    },
    '3ct4fj7p': {
      'en': 'Change Account',
      'ar': 'تغيير الحساب',
      'zh_Hans': '更改帐户',
      'zh_Hant': '變更帳戶',
    },
    'w4smsh2i': {
      'en': 'Internal Transfer',
      'ar': 'نقل داخلي',
      'zh_Hans': '内部转帐',
      'zh_Hant': '內部轉帳',
    },
    '6uxty3hy': {
      'en': 'External Transfer',
      'ar': 'نقل خارجي',
      'zh_Hans': '外部转移',
      'zh_Hant': '外部轉移',
    },
    'p4ngma0d': {
      'en': 'ACH Payment',
      'ar': 'الدفع عبر ACH',
      'zh_Hans': 'ACH付款',
      'zh_Hant': 'ACH支付',
    },
    'uxo87fjc': {
      'en': 'Transfer Type',
      'ar': 'نوع النقل',
      'zh_Hans': '传输类型',
      'zh_Hant': '傳輸類型',
    },
    'fddma8xl': {
      'en': 'Select Account',
      'ar': 'حدد الحساب',
      'zh_Hans': '选择帐户',
      'zh_Hant': '選擇帳戶',
    },
    '23l6kqgm': {
      'en': 'Account ****2010',
      'ar': 'الحساب ****2010',
      'zh_Hans': '帐户****2010',
      'zh_Hant': '帳戶****2010',
    },
    '3hwdfadf': {
      'en': 'Account ****2011',
      'ar': 'الحساب ****2011',
      'zh_Hans': '帐户****2011',
      'zh_Hant': '帳戶****2011',
    },
    'xvj00xg1': {
      'en': 'Account ****2012',
      'ar': 'الحساب ****2012',
      'zh_Hans': '帐户****2012',
      'zh_Hant': '帳戶****2012',
    },
    'ok5xluvk': {
      'en': 'Choose an Account',
      'ar': 'اختر حساب',
      'zh_Hans': '选择一个帐户',
      'zh_Hant': '選擇一個帳戶',
    },
    'ynie0pc5': {
      'en': '\$ Amount',
      'ar': 'المبلغ \$',
      'zh_Hans': '\$ 金额',
      'zh_Hant': '\$ 金額',
    },
    'wngoi0v4': {
      'en': 'Your new account balance is:',
      'ar': 'رصيد حسابك الجديد هو:',
      'zh_Hans': '您的新帐户余额为：',
      'zh_Hant': '您的新帳戶餘額是：',
    },
    'g6bfec2g': {
      'en': '\$7,630',
      'ar': '7,630 دولار',
      'zh_Hans': '\$7,630',
      'zh_Hant': '7,630 美元',
    },
    'xaw2jdst': {
      'en': 'Send Transfer',
      'ar': 'إرسال التحويل',
      'zh_Hans': '发送转账',
      'zh_Hant': '發送轉帳',
    },
    'xku4zxbe': {
      'en': 'Tap above to complete transfer',
      'ar': 'انقر أعلاه لإكمال النقل',
      'zh_Hans': '点击上方即可完成转移',
      'zh_Hant': '點擊上方即可完成轉賬',
    },
    'imaejg7x': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // requestFunds
  {
    'wv1862li': {
      'en': 'Request Funds',
      'ar': 'طلب الأموال',
      'zh_Hans': '请求资金',
      'zh_Hant': '請求資金',
    },
    'xvj3fan8': {
      'en': '\$ Amount',
      'ar': 'المبلغ \$',
      'zh_Hans': '\$ 金额',
      'zh_Hant': '\$ 金額',
    },
    'wwjahvpl': {
      'en': 'Office Budget',
      'ar': 'ميزانية المكتب',
      'zh_Hans': '办公室预算',
      'zh_Hant': '辦公室預算',
    },
    'sx0vvzxd': {
      'en': 'External Transfer',
      'ar': 'نقل خارجي',
      'zh_Hans': '外部转移',
      'zh_Hant': '外部轉移',
    },
    'ai453kej': {
      'en': 'ACH Payment',
      'ar': 'الدفع عبر ACH',
      'zh_Hans': 'ACH付款',
      'zh_Hant': 'ACH支付',
    },
    'wo9cebk7': {
      'en': 'Select Transfer',
      'ar': 'حدد النقل',
      'zh_Hans': '选择转移',
      'zh_Hant': '選擇轉移',
    },
    'rcevwwju': {
      'en': 'Reason',
      'ar': 'سبب',
      'zh_Hans': '原因',
      'zh_Hant': '原因',
    },
    'uvrt7im0': {
      'en': 'Request Funds',
      'ar': 'طلب الأموال',
      'zh_Hans': '请求资金',
      'zh_Hant': '請求資金',
    },
    '7y89msg9': {
      'en': 'Tap above to complete request',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'zh_Hans': '点按上方以完成请求',
      'zh_Hant': '點擊上方即可完成請求',
    },
    'xk0bwox3': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // createBudget
  {
    'smbfunwu': {
      'en': 'Create Budget',
      'ar': 'إنشاء الميزانية',
      'zh_Hans': '创建预算',
      'zh_Hant': '建立預算',
    },
    'fcgw57wj': {
      'en': 'Amount',
      'ar': 'كمية',
      'zh_Hans': '数量',
      'zh_Hant': '數量',
    },
    'onjddqdc': {
      'en': 'Budget Name',
      'ar': 'اسم الميزانية',
      'zh_Hans': '预算名称',
      'zh_Hant': '預算名稱',
    },
    'g83gfmaf': {
      'en': 'Description',
      'ar': 'وصف',
      'zh_Hans': '描述',
      'zh_Hant': '描述',
    },
    '0iex13x2': {
      'en': 'Create Budget',
      'ar': 'إنشاء الميزانية',
      'zh_Hans': '创建预算',
      'zh_Hant': '建立預算',
    },
    'jy5q09h1': {
      'en': 'Tap above to complete request',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'zh_Hans': '点按上方以完成请求',
      'zh_Hant': '點擊上方即可完成請求',
    },
    '8hzaiw1r': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    'mos068mm': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // transaction_ADD
  {
    'qywon4k1': {
      'en': 'Add Transaction',
      'ar': 'إضافة معاملة',
      'zh_Hans': '添加交易',
      'zh_Hant': '新增交易',
    },
    'bh9tad8e': {
      'en': 'Amount',
      'ar': 'كمية',
      'zh_Hans': '数量',
      'zh_Hant': '數量',
    },
    'ohewrgsv': {
      'en': 'Spent At',
      'ar': 'تم إنفاقه في',
      'zh_Hans': '花费在',
      'zh_Hant': '花費於',
    },
    '3170k9n1': {
      'en': 'Office Budget',
      'ar': 'ميزانية المكتب',
      'zh_Hans': '办公室预算',
      'zh_Hant': '辦公室預算',
    },
    'abz6nm8z': {
      'en': 'External Transfer',
      'ar': 'نقل خارجي',
      'zh_Hans': '外部转移',
      'zh_Hant': '外部轉移',
    },
    '3y95vtb6': {
      'en': 'ACH Payment',
      'ar': 'الدفع عبر ACH',
      'zh_Hans': 'ACH付款',
      'zh_Hant': 'ACH支付',
    },
    '861el4k4': {
      'en': 'Select Budget',
      'ar': 'حدد الميزانية',
      'zh_Hans': '选择预算',
      'zh_Hant': '選擇預算',
    },
    'swxms7ln': {
      'en': 'Reason',
      'ar': 'سبب',
      'zh_Hans': '原因',
      'zh_Hant': '原因',
    },
    'uqfgu088': {
      'en': 'Add Transaction',
      'ar': 'إضافة معاملة',
      'zh_Hans': '添加交易',
      'zh_Hant': '新增交易',
    },
    '9stmpsf0': {
      'en': 'Tap above to complete request',
      'ar': 'اضغط أعلاه لإكمال الطلب',
      'zh_Hans': '点按上方以完成请求',
      'zh_Hant': '點擊上方即可完成請求',
    },
    'gzhmf1t6': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    '7trcsuiu': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // transaction_EDIT
  {
    's300dyxl': {
      'en': 'Edit Transaction',
      'ar': 'تعديل المعاملة',
      'zh_Hans': '编辑交易',
      'zh_Hant': '編輯交易',
    },
    '5xgwlwjj': {
      'en': 'Amount',
      'ar': 'كمية',
      'zh_Hans': '数量',
      'zh_Hant': '數量',
    },
    '720k2d98': {
      'en': 'Spent At',
      'ar': 'تم إنفاقه في',
      'zh_Hans': '花费在',
      'zh_Hant': '花費於',
    },
    'df1ingy2': {
      'en': 'Office Budget',
      'ar': 'ميزانية المكتب',
      'zh_Hans': '办公室预算',
      'zh_Hant': '辦公室預算',
    },
    '5kzmka3y': {
      'en': 'External Transfer',
      'ar': 'نقل خارجي',
      'zh_Hans': '外部转移',
      'zh_Hant': '外部轉移',
    },
    'nvtz0bpd': {
      'en': 'ACH Payment',
      'ar': 'الدفع عبر ACH',
      'zh_Hans': 'ACH付款',
      'zh_Hant': 'ACH支付',
    },
    'l3bqo3oh': {
      'en': 'Select Budget',
      'ar': 'حدد الميزانية',
      'zh_Hans': '选择预算',
      'zh_Hant': '選擇預算',
    },
    '0lw03w43': {
      'en': 'Reason',
      'ar': 'سبب',
      'zh_Hans': '原因',
      'zh_Hant': '原因',
    },
    '3eftlbxd': {
      'en': 'Update Transaction',
      'ar': 'تحديث المعاملة',
      'zh_Hans': '更新交易',
      'zh_Hant': '更新交易',
    },
    '4atjd0yh': {
      'en': 'Tap above to save your changes.',
      'ar': 'انقر أعلاه لحفظ التغييرات.',
      'zh_Hans': '点击上方即可保存您的更改。',
      'zh_Hant': '點擊上面儲存您的變更。',
    },
    'pg18rcyu': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    '12if11ss': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // editProfile
  {
    '4rzqov3y': {
      'en': 'Edit Profile',
      'ar': 'تعديل الملف الشخصي',
      'zh_Hans': '編輯資料',
      'zh_Hant': '編輯個人資料',
    },
    'zoxan2gi': {
      'en': 'Change Photo',
      'ar': 'تغيير الصورة',
      'zh_Hans': '更改照片',
      'zh_Hant': '更改照片',
    },
    '3p9y21e2': {
      'en': 'Your Name',
      'ar': 'اسمك',
      'zh_Hans': '您的名字',
      'zh_Hant': '你的名字',
    },
    'dw9gmjdc': {
      'en': 'Please enter a valid number...',
      'ar': 'الرجاء إدخال رقم صالح...',
      'zh_Hans': '请输入有效的数字...',
      'zh_Hant': '請輸入有效的號碼...',
    },
    'z4fstn5l': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'zh_Hans': '电子邮件',
      'zh_Hant': '電子郵件',
    },
    'jozgvwyg': {
      'en': 'Your email',
      'ar': 'بريدك الالكتروني',
      'zh_Hans': '您的电子邮件地址',
      'zh_Hant': '您的電子郵件',
    },
    '8h1cjk5a': {
      'en': 'Your Age',
      'ar': 'عمرك',
      'zh_Hans': '你的年龄',
      'zh_Hant': '你的年齡',
    },
    '5v21r6gb': {
      'en': 'i.e. 34',
      'ar': 'أي 34',
      'zh_Hans': '即 34',
      'zh_Hant': '即 34',
    },
    'zvymbfia': {
      'en': 'Your Title',
      'ar': 'عنوانك',
      'zh_Hans': '你的头衔',
      'zh_Hant': '您的頭銜',
    },
    'i6edcl52': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'zh_Hans': '保存更改',
      'zh_Hant': '儲存變更',
    },
    '59naq8ur': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // changePassword
  {
    'l5iggwaz': {
      'en': 'Change Password',
      'ar': 'تغيير كلمة المرور',
      'zh_Hans': '更改密码',
      'zh_Hant': '更改密碼',
    },
    '2b97u8y5': {
      'en':
          'Enter the email associated with your account and we will send you link to reset your password.',
      'ar':
          'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطًا لإعادة تعيين كلمة المرور الخاصة بك.',
      'zh_Hans': '输入与您的帐户关联的电子邮件，我们将向您发送重置密码的链接。',
      'zh_Hant': '輸入與您的帳戶關聯的電子郵件，我們將向您發送重設密碼的連結。',
    },
    'ajy1c3r9': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'zh_Hans': '电子邮件',
      'zh_Hant': '電子郵件',
    },
    'hsqfoxya': {
      'en': 'Enter your email...',
      'ar': 'أدخل بريدك الإلكتروني...',
      'zh_Hans': '输入您的电子邮件...',
      'zh_Hant': '輸入您的電子郵件...',
    },
    'if4pz6lm': {
      'en': 'Send Reset Link',
      'ar': 'إرسال رابط إعادة الضبط',
      'zh_Hans': '发送重置链接',
      'zh_Hant': '發送重置連結',
    },
    '5tvk9lv0': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // notificationsSettings
  {
    'sc4ff4ce': {
      'en': 'Notifications',
      'ar': 'إشعارات',
      'zh_Hans': '通知',
      'zh_Hant': '通知',
    },
    'r72zvrv5': {
      'en':
          'Choose what notifcations you want to recieve below and we will update the settings.',
      'ar':
          'قم باختيار الإشعارات التي تريد تلقيها أدناه وسوف نقوم بتحديث الإعدادات.',
      'zh_Hans': '选择您想要接收的通知，我们将更新设置。',
      'zh_Hant': '在下方選擇您想要接收的通知，我們將更新設定。',
    },
    'gjygkr0n': {
      'en': 'Push Notifications',
      'ar': 'الإشعارات الفورية',
      'zh_Hans': '推送通知',
      'zh_Hant': '推播通知',
    },
    '3y3yhxbk': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'ar': 'احصل على إشعارات الدفع من تطبيقنا على أساس شبه منتظم.',
      'zh_Hans': '定期从我们的应用程序接收推送通知。',
      'zh_Hant': '定期從我們的應用程式接收推播通知。',
    },
    '1ytebj35': {
      'en': 'Email Notifications',
      'ar': 'إشعارات البريد الإلكتروني',
      'zh_Hans': '电子邮件通知',
      'zh_Hant': '電子郵件通知',
    },
    '9lvh5nst': {
      'en':
          'Receive email notifications from our marketing team about new features.',
      'ar':
          'احصل على إشعارات عبر البريد الإلكتروني من فريق التسويق لدينا حول الميزات الجديدة.',
      'zh_Hans': '接收我们的营销团队发送的有关新功能的电子邮件通知。',
      'zh_Hant': '接收來自我們行銷團隊的有關新功能的電子郵件通知。',
    },
    '69d2j74u': {
      'en': 'Location Services',
      'ar': 'خدمات تحديد الموقع',
      'zh_Hans': '定位服务',
      'zh_Hant': '定位服務',
    },
    '3k8cuv0d': {
      'en':
          'Allow us to track your location, this helps keep track of spending and keeps you safe.',
      'ar':
          'اسمح لنا بتتبع موقعك، وهذا يساعد في تتبع الإنفاق ويحافظ على سلامتك.',
      'zh_Hans': '允许我们追踪您的位置，这有助于追踪您的消费并确保您的安全。',
      'zh_Hant': '允許我們追蹤您的位置，這有助於追蹤支出並確保您的安全。',
    },
    'isgrgbfs': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'zh_Hans': '保存更改',
      'zh_Hant': '儲存變更',
    },
    'a96mlyeh': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // LAW
  {
    'alczfiiy': {
      'en': 'Privacy Policy',
      'ar': 'سياسة الخصوصية',
      'zh_Hans': '隐私政策',
      'zh_Hant': '隱私權政策',
    },
    'fvsfg5on': {
      'en': 'How we use your data',
      'ar': 'كيف نستخدم بياناتك',
      'zh_Hans': '我们如何使用您的数据',
      'zh_Hant': '我們如何使用您的數據',
    },
    'nbiyrnzl': {
      'en':
          'Data Collection \nWe collect information you provide when using our cryptocurrency wallet application, including but not limited to:\n\nRegistration information (such as username, password, email address) \nTransaction records and account balances\nDevice information and usage data (such as IP address, browser type, access time) \nPurpose of Data Use \nWe will use your data for the following purposes:\n\nTo provide and maintain our services, including processing transactions and managing accounts \nTo enhance user experience and personalize service content \nTo send important account and service notifications\nTo analyze user behavior to improve application features and performance \nTo comply with legal requirements and protect user rights \nData Sharing\nWe do not sell your personal data to third parties. We may share your data in the following circumstances:\n\nWhen required by law \nWith trusted service providers to help us deliver our services (such as payment processing, data analysis) \nWith your explicit consent for data sharing\nData Security \nWe take reasonable technical and organizational measures to protect your data from unauthorized access, use, or disclosure. While we are committed to protecting your personal information, no method of data transmission or storage is 100% secure.\n\nUser Rights \nYou have the right to access, modify, or delete your personal data. You can exercise these rights through the application settings or by contacting customer service. \n\nChanges to Terms \nWe may update these terms from time to time, and any changes will be notified to you within the application. Please review these terms regularly to understand how we use your data.',
      'ar':
          'جمع البيانات\nنقوم بجمع المعلومات التي تقدمها عند استخدام تطبيق محفظة العملات المشفرة الخاص بنا، بما في ذلك على سبيل المثال لا الحصر:\n\nمعلومات التسجيل (مثل اسم المستخدم وكلمة المرور وعنوان البريد الإلكتروني)\n\nسجلات المعاملات وأرصدة الحسابات\nمعلومات الجهاز وبيانات الاستخدام (مثل عنوان IP ونوع المتصفح ووقت الوصول)\n\nالغرض من استخدام البيانات\nسنستخدم بياناتك للأغراض التالية:\n\nلتوفير خدماتنا وصيانتها، بما في ذلك معالجة المعاملات وإدارة الحسابات\nلتحسين تجربة المستخدم وتخصيص محتوى الخدمة\nلإرسال إشعارات مهمة حول الحساب والخدمة\nلتحليل سلوك المستخدم لتحسين ميزات التطبيق والأداء\nللامتثال للمتطلبات القانونية وحماية حقوق المستخدم\nمشاركة البيانات\nلا نبيع بياناتك الشخصية لأطراف ثالثة. يجوز لنا مشاركة بياناتك في الحالات التالية:\n\nعندما يقتضي القانون ذلك\nمع مقدمي الخدمات الموثوق بهم لمساعدتنا في تقديم خدماتنا (مثل معالجة الدفع وتحليل البيانات)\nبموافقتك الصريحة على مشاركة البيانات\nأمان البيانات\nنتخذ تدابير فنية وتنظيمية معقولة لحماية بياناتك من الوصول غير المصرح به أو الاستخدام أو الكشف عنها. على الرغم من التزامنا بحماية معلوماتك الشخصية، لا توجد طريقة آمنة بنسبة 100% لنقل البيانات أو تخزينها.\n\nحقوق المستخدم\nلديك الحق في الوصول إلى بياناتك الشخصية أو تعديلها أو حذفها. يمكنك ممارسة هذه الحقوق من خلال إعدادات التطبيق أو عن طريق الاتصال بخدمة العملاء.\n\nتغييرات الشروط\nقد نقوم بتحديث هذه الشروط من وقت لآخر، وسيتم إخطارك بأي تغييرات داخل التطبيق. يرجى مراجعة هذه الشروط بانتظام لفهم كيفية استخدامنا لبياناتك.',
      'zh_Hans':
          '数据收集\n我们收集您在使用我们的加密货币钱包应用程序时提供的信息，包括但不限于：\n\n注册信息（如用户名、密码、电子邮件地址）\n交易记录和账户余额\n设备信息和使用数据（如IP地址、浏览器类型、访问时间）\n数据使用目的\n我们将使用您的数据用于以下目的：\n\n提供和维护我们的服务，包括处理交易和管理账户\n提升用户体验和个性化服务内容\n发送重要的账户和服务通知\n分析用户行为以改进应用程序功能和性能\n遵守法律要求并保护用户权利\n数据共享\n我们不会向第三方出售您的个人数据。我们可能会在以下情况下共享您的数据：\n\n法律要求时\n与可信赖的服务提供商共享，以帮助我们提供服务（如支付处理、数据分析）\n在您明确同意数据共享的情况下\n数据安全\n我们采取合理的技术和组织措施来保护您的数据免遭未经授权的访问、使用或泄露。虽然我们致力于保护您的个人信息，但没有任何数据传输或存储方法是 100% 安全的。\n\n用户权利\n您有权访问、修改或删除您的个人数据。您可以通过应用程序设置或联系客服来行使这些权利。\n\n条款变更\n我们可能会不时更新这些条款，任何变更都会在应用程序内通知您。请定期查看这些条款，以了解我们如何使用您的数据。',
      'zh_Hant':
          '數據收集 \n我們收集您在使用我們的加密貨幣錢包應用程式時提供的信息，包括但不限於：\n\n註冊資訊（例如使用者名稱、密碼、電子郵件地址） \n交易記錄及帳戶餘額\n設備資訊和使用資料（例如IP位址、瀏覽器類型、存取時間） \n數據使用目的 \n我們會將您的資料用於以下目的：\n\n提供和維護我們的服務，包括處理交易和管理帳戶 \n提升使用者體驗，個人化服務內容 \n發送重要的帳戶和服務通知\n分析使用者行為以改善應用程式功能和效能 \n遵守法律要求並保護使用者權利 \n數據共享\n我們不會將您的個人資料出售給第三方。我們可能會在以下情況下共享您的資料：\n\n當法律要求時 \n與值得信賴的服務提供者一起幫助我們提供服務（例如支付處理、數據分析） \n在您明確同意資料共享的情況下\n資料安全 \n我們採取合理的技術和組織措施來保護您的資料免於未經授權的存取、使用或揭露。雖然我們致力於保護您的個人訊息，但沒有一種資料傳輸或儲存方法是 100% 安全的。\n\n使用者權利 \n您有權存取、修改或刪除您的個人資料。您可以透過應用程式設定或聯絡客戶服務來行使這些權利。 \n\n條款變更 \n我們可能會不時更新這些條款，任何變更將在應用程式中通知您。請定期查看這些條款，以了解我們如何使用您的資料。',
    },
    'oks4x95o': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '家',
      'zh_Hant': '家',
    },
  },
  // tutorial_PROFILE
  {
    '38wb3rix': {
      'en': 'Tutorial',
      'ar': 'درس تعليمي',
      'zh_Hans': '教程',
      'zh_Hant': '教學',
    },
    'o6prpb1q': {
      'en': 'Create Budgets',
      'ar': 'إنشاء الميزانيات',
      'zh_Hans': '创建预算',
      'zh_Hant': '建立預算',
    },
    '292pbdw7': {
      'en':
          'Create budgets that you can tie transactions too in order for easy tracking.',
      'ar': 'قم بإنشاء ميزانيات يمكنك ربط المعاملات بها لتسهيل تتبعها.',
      'zh_Hans': '创建可以与交易绑定的预算，以便于跟踪。',
      'zh_Hant': '建立預算，您也可以將其與交易聯繫起來，以便於追蹤。',
    },
    'b10xvuf9': {
      'en': 'Keep Track of Spending',
      'ar': 'تتبع الإنفاق',
      'zh_Hans': '记录支出',
      'zh_Hant': '追蹤支出',
    },
    't6k1smsm': {
      'en':
          'Easily add transactions and associate them with budgets that have been created.',
      'ar': 'يمكنك بسهولة إضافة المعاملات وربطها بالميزانيات التي تم إنشاؤها.',
      'zh_Hans': '轻松添加交易并将其与已创建的预算关联。',
      'zh_Hant': '輕鬆新增交易並將其與已建立的預算相關聯。',
    },
    'u8xxj427': {
      'en': 'Budget Analysis',
      'ar': 'تحليل الميزانية',
      'zh_Hans': '预算分析',
      'zh_Hant': '預算分析',
    },
    'iqi0pkmb': {
      'en': 'Know where your budgets are and how they can be adjusted.',
      'ar': 'تعرف على مكان ميزانيتك وكيف يمكن تعديلها.',
      'zh_Hans': '了解您的预算在哪里以及如何调整预算。',
      'zh_Hant': '了解您的預算在哪裡以及如何調整它們。',
    },
    'uydm0fnm': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // homePage
  {
    'ucqlrrlk': {
      'en': 'Welcome,',
      'ar': 'مرحباً،',
      'zh_Hans': '欢迎，',
      'zh_Hant': '歡迎，',
    },
    'c10wb3ot': {
      'en': 'Your account Details are below.',
      'ar': 'تفاصيل حسابك موجودة أدناه.',
      'zh_Hans': '您的帐户详情如下。',
      'zh_Hant': '您的帳戶詳細資料如下。',
    },
    '6z1sm34j': {
      'en': 'Total Balance',
      'ar': 'الرصيد الإجمالي',
      'zh_Hans': '总余额',
      'zh_Hant': '總餘額',
    },
    'c0dls4u5': {
      'en': '\$25,202',
      'ar': '25202 دولار',
      'zh_Hans': '\$25,202',
      'zh_Hant': '\$25,202 美元',
    },
    '30yef7fj': {
      'en': 'Payroll Due',
      'ar': 'الراتب المستحق',
      'zh_Hans': '工资单到期',
      'zh_Hant': '應付薪資',
    },
    'zrx9e6tv': {
      'en': '\$12,245',
      'ar': '12,245 دولار',
      'zh_Hans': '12,245美元',
      'zh_Hant': '\$12,245',
    },
    '1cjqanzg': {
      'en': 'Debit Date',
      'ar': 'تاريخ الخصم',
      'zh_Hans': '付款日期',
      'zh_Hant': '金融日期',
    },
    '726vrs60': {
      'en': 'Aug 31, 2021',
      'ar': '31 أغسطس 2021',
      'zh_Hans': '2021 年 8 月 31 日',
      'zh_Hant': '2021 年 8 月 31 日',
    },
    '4dgbx46t': {
      'en': '4 Days Left',
      'ar': '4 أيام متبقية',
      'zh_Hans': '还剩 4 天',
      'zh_Hant': '還剩 4 天',
    },
    'n87v5tth': {
      'en': 'Marketing Budget',
      'ar': 'ميزانية التسويق',
      'zh_Hans': '营销预算',
      'zh_Hant': '行銷預算',
    },
    'l5pw5c8c': {
      'en': '\$4,000',
      'ar': '4000 دولار',
      'zh_Hans': '4,000 美元',
      'zh_Hant': '4,000 美元',
    },
    '7i0a44qa': {
      'en': 'Total Spent',
      'ar': 'إجمالي الإنفاق',
      'zh_Hans': '总花费',
      'zh_Hant': '總花費',
    },
    '9a2ya1la': {
      'en': '\$3,402',
      'ar': '3,402 دولار',
      'zh_Hans': '\$3,402',
      'zh_Hant': '\$3,402 美元',
    },
    'n1o498d9': {
      'en': '4 Days Left',
      'ar': '4 أيام متبقية',
      'zh_Hans': '还剩 4 天',
      'zh_Hant': '還剩 4 天',
    },
    'lmo3ko2i': {
      'en': 'Quick Services',
      'ar': 'خدمات سريعة',
      'zh_Hans': '快速服务',
      'zh_Hant': '快速服務',
    },
    '774itrkn': {
      'en': 'My Bank',
      'ar': 'بنكي',
      'zh_Hans': '我的银行',
      'zh_Hant': '我的銀行',
    },
    'xs2as0vf': {
      'en': 'Transfer',
      'ar': 'تحويل',
      'zh_Hans': '转移',
      'zh_Hant': '轉移',
    },
    'g8yaaa7f': {
      'en': 'Activity',
      'ar': 'نشاط',
      'zh_Hans': '活动',
      'zh_Hant': '活動',
    },
    'c805m53i': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // homePage_alt
  {
    'xdh0z8qh': {
      'en': 'Welcome,',
      'ar': 'مرحباً،',
      'zh_Hans': '欢迎，',
      'zh_Hant': '歡迎，',
    },
    'v74pa882': {
      'en': 'Andrew',
      'ar': 'أندرو',
      'zh_Hans': '安德鲁',
      'zh_Hant': '安德魯',
    },
    'rzpg3cvh': {
      'en': 'Your latest updates are below.',
      'ar': 'آخر التحديثات الخاصة بك موجودة أدناه.',
      'zh_Hans': '您的最新更新如下。',
      'zh_Hant': '您的最新更新如下。',
    },
    'flto6ti8': {
      'en': 'Total Balance',
      'ar': 'الرصيد الإجمالي',
      'zh_Hans': '总余额',
      'zh_Hant': '總餘額',
    },
    'g07h0azf': {
      'en': '\$25,281',
      'ar': '25,281 دولار',
      'zh_Hans': '\$25,281',
      'zh_Hant': '25,281 美元',
    },
    'v9ghmn0y': {
      'en': 'Total Balance',
      'ar': 'الرصيد الإجمالي',
      'zh_Hans': '总余额',
      'zh_Hant': '總餘額',
    },
    '7vf40ybo': {
      'en': '\$25,281',
      'ar': '25,281 دولار',
      'zh_Hans': '\$25,281',
      'zh_Hant': '25,281 美元',
    },
    'k4scs2cu': {
      'en': 'Total Balance',
      'ar': 'الرصيد الإجمالي',
      'zh_Hans': '总余额',
      'zh_Hant': '總餘額',
    },
    'cvrbfozm': {
      'en': '\$25,281',
      'ar': '25,281 دولار',
      'zh_Hans': '\$25,281',
      'zh_Hant': '25,281 美元',
    },
    'a33ldz0h': {
      'en': 'Next Payroll',
      'ar': 'الرواتب القادمة',
      'zh_Hans': '下一个工资单',
      'zh_Hant': '下一個薪資單',
    },
    '3dgzzz79': {
      'en': '\$25,281',
      'ar': '25,281 دولار',
      'zh_Hans': '\$25,281',
      'zh_Hant': '25,281 美元',
    },
    'hp28r17l': {
      'en': 'Debit Date',
      'ar': 'تاريخ الخصم',
      'zh_Hans': '付款日期',
      'zh_Hant': '金融日期',
    },
    'k04gl6sz': {
      'en': 'Aug 31, 2021',
      'ar': '31 أغسطس 2021',
      'zh_Hans': '2021 年 8 月 31 日',
      'zh_Hant': '2021 年 8 月 31 日',
    },
    'd5tcdo3w': {
      'en': '4 days left',
      'ar': '4 أيام متبقية',
      'zh_Hans': '还剩 4 天',
      'zh_Hant': '還剩 4 天',
    },
    '8wofym4i': {
      'en': '1 New Alert',
      'ar': '1 تنبيه جديد',
      'zh_Hans': '1 个新警报',
      'zh_Hant': '1 個新警報',
    },
    'kaq4nzj6': {
      'en': 'Fraud Alert',
      'ar': 'تنبيه الاحتيال',
      'zh_Hans': '欺诈警报',
      'zh_Hant': '詐騙警報',
    },
    '7zcrtqx6': {
      'en':
          'We noticed a small charge that is out of character of this account, please review.',
      'ar':
          'لقد لاحظنا رسومًا صغيرة لا تتناسب مع طبيعة هذا الحساب، يرجى المراجعة.',
      'zh_Hans': '我们注意到有一笔与该帐户不符的小额费用，请审核。',
      'zh_Hant': '我們注意到一筆不符合該帳戶特徵的小額費用，請查看。',
    },
    '23yxoc9m': {
      'en': 'View Now',
      'ar': 'شاهد الآن',
      'zh_Hans': '立即查看',
      'zh_Hant': '立即查看',
    },
    'a86mwddx': {
      'en': 'Marketing Budget',
      'ar': 'ميزانية التسويق',
      'zh_Hans': '营销预算',
      'zh_Hant': '行銷預算',
    },
    '6c2o39hz': {
      'en': '\$3,000',
      'ar': '3000 دولار',
      'zh_Hans': '3,000 美元',
      'zh_Hant': '3,000 美元',
    },
    '5subrra4': {
      'en': 'Total Spent',
      'ar': 'إجمالي الإنفاق',
      'zh_Hans': '总花费',
      'zh_Hant': '總花費',
    },
    '0wtm2m51': {
      'en': '\$2,502',
      'ar': '2,502 دولار',
      'zh_Hans': '\$2,502',
      'zh_Hant': '\$2,502 美元',
    },
    'bp9d56pc': {
      'en': '4 days left',
      'ar': '4 أيام متبقية',
      'zh_Hans': '还剩 4 天',
      'zh_Hant': '還剩 4 天',
    },
    'b8oj0pck': {
      'en': 'Team Name',
      'ar': 'اسم الفريق',
      'zh_Hans': '团队名称',
      'zh_Hant': '團隊名稱',
    },
    '87ospwsq': {
      'en': '\$5,000',
      'ar': '5000 دولار',
      'zh_Hans': '5,000 美元',
      'zh_Hant': '5,000 美元',
    },
    'jzfejglt': {
      'en': 'Head of Design',
      'ar': 'رئيس التصميم',
      'zh_Hans': '设计主管',
      'zh_Hant': '設計主管',
    },
    'zm0lhm2a': {
      'en': '[Time Stamp]',
      'ar': '[الطابع الزمني]',
      'zh_Hans': '[时间戳]',
      'zh_Hant': '[時間戳]',
    },
    '8hu2v2im': {
      'en': '•',
      'ar': '•',
      'zh_Hans': '•',
      'zh_Hant': '•',
    },
  },
  // homePage_alt_1
  {
    '51kawpgz': {
      'en': 'Welcome,',
      'ar': 'مرحباً،',
      'zh_Hans': '欢迎，',
      'zh_Hant': '歡迎，',
    },
    'izgc0c6r': {
      'en': 'Andrew',
      'ar': 'أندرو',
      'zh_Hans': '安德鲁',
      'zh_Hant': '安德魯',
    },
    '30kx6e5v': {
      'en': 'Your latest updates are below.',
      'ar': 'آخر التحديثات الخاصة بك موجودة أدناه.',
      'zh_Hans': '您的最新更新如下。',
      'zh_Hant': '您的最新更新如下。',
    },
    'wknu2tm4': {
      'en': 'Balance',
      'ar': 'توازن',
      'zh_Hans': '平衡',
      'zh_Hant': '平衡',
    },
    'syy689nt': {
      'en': '\$7,630',
      'ar': '7,630 دولار',
      'zh_Hans': '\$7,630',
      'zh_Hant': '7,630 美元',
    },
    'hhyb9x4x': {
      'en': '**** 0149',
      'ar': '**** 0149',
      'zh_Hans': '**** 0149',
      'zh_Hant': '****0149',
    },
    'kg2tmby7': {
      'en': '05/25',
      'ar': '25/05',
      'zh_Hans': '05/25',
      'zh_Hant': '05/25',
    },
    'y7zomzzp': {
      'en': 'Quick Service',
      'ar': 'خدمة سريعة',
      'zh_Hans': '快速服务',
      'zh_Hant': '快速服務',
    },
    'rfozud9v': {
      'en': 'Transfer',
      'ar': 'تحويل',
      'zh_Hans': '转移',
      'zh_Hant': '轉移',
    },
    'pcrarg0a': {
      'en': 'Activity',
      'ar': 'نشاط',
      'zh_Hans': '活动',
      'zh_Hant': '活動',
    },
    'zmjsfzgg': {
      'en': 'My Bank',
      'ar': 'بنكي',
      'zh_Hans': '我的银行',
      'zh_Hant': '我的銀行',
    },
    'dfjtbkbo': {
      'en': 'Transaction',
      'ar': 'عملية',
      'zh_Hans': '交易',
      'zh_Hant': '交易',
    },
    'g7t9krj7': {
      'en': 'Go Far Rewards',
      'ar': 'مكافآت Go Far',
      'zh_Hans': '远行奖励',
      'zh_Hant': '走得更遠獎勵',
    },
    'vupu5y5p': {
      'en': 'Income',
      'ar': 'دخل',
      'zh_Hans': '收入',
      'zh_Hant': '收入',
    },
    'bj5qnrj5': {
      'en': '\$50.00',
      'ar': '50.00 دولار',
      'zh_Hans': '50.00 美元',
      'zh_Hant': '\$50.00',
    },
    'd1n5mbq7': {
      'en': 'Hello World',
      'ar': 'مرحبا بالعالم',
      'zh_Hans': '你好世界',
      'zh_Hant': '你好世界',
    },
    '2thn73jc': {
      'en': 'Go Far Rewards',
      'ar': 'مكافآت Go Far',
      'zh_Hans': '远行奖励',
      'zh_Hant': '走得更遠獎勵',
    },
    '1fjdiibo': {
      'en': 'Income',
      'ar': 'دخل',
      'zh_Hans': '收入',
      'zh_Hant': '收入',
    },
    'ld7s2fpn': {
      'en': '\$50.00',
      'ar': '50.00 دولار',
      'zh_Hans': '50.00 美元',
      'zh_Hant': '\$50.00',
    },
    'ft8bu1we': {
      'en': 'Hello World',
      'ar': 'مرحبا بالعالم',
      'zh_Hans': '你好世界',
      'zh_Hant': '你好世界',
    },
    '8t6ddwco': {
      'en': 'Go Far Rewards',
      'ar': 'مكافآت Go Far',
      'zh_Hans': '远行奖励',
      'zh_Hant': '走得更遠獎勵',
    },
    'td15kjsa': {
      'en': 'Income',
      'ar': 'دخل',
      'zh_Hans': '收入',
      'zh_Hant': '收入',
    },
    'qmjqp9a6': {
      'en': '\$50.00',
      'ar': '50.00 دولار',
      'zh_Hans': '50.00 美元',
      'zh_Hant': '\$50.00',
    },
    '9qc797et': {
      'en': 'Hello World',
      'ar': 'مرحبا بالعالم',
      'zh_Hans': '你好世界',
      'zh_Hant': '你好世界',
    },
    '8pdmehj2': {
      'en': 'Go Far Rewards',
      'ar': 'مكافآت Go Far',
      'zh_Hans': '远行奖励',
      'zh_Hant': '走得更遠獎勵',
    },
    'krrhjgc4': {
      'en': 'Income',
      'ar': 'دخل',
      'zh_Hans': '收入',
      'zh_Hant': '收入',
    },
    '53m2u0s2': {
      'en': '\$50.00',
      'ar': '50.00 دولار',
      'zh_Hans': '50.00 美元',
      'zh_Hant': '\$50.00',
    },
    'aks5zz4f': {
      'en': 'Hello World',
      'ar': 'مرحبا بالعالم',
      'zh_Hans': '你好世界',
      'zh_Hant': '你好世界',
    },
    'f3hxl69y': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // AccountStatement
  {
    'pozov0xz': {
      'en': 'Account Statement',
      'ar': 'Account Statement',
      'zh_Hans': 'Account Statement',
      'zh_Hant': 'Account Statement',
    },
    '9l7pbjcj': {
      'en': 'Download ↓',
      'ar': 'Download ↓',
      'zh_Hans': 'Download ↓',
      'zh_Hant': 'Download ↓',
    },
    'b1xp801p': {
      'en': 'Home',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
  },
  // profilepage
  {
    'hhb6veym': {
      'en': 'Wallet Balance',
      'ar': 'رصيد المحفظة',
      'zh_Hans': '钱包余额',
      'zh_Hant': '錢包餘額',
    },
    'fgf8icmv': {
      'en': '\$00.00',
      'ar': '00.00 دولار',
      'zh_Hans': '\$00.00',
      'zh_Hant': '\$00.00',
    },
    '2rrr446m': {
      'en': '3 currencies',
      'ar': '3 عملات',
      'zh_Hans': '3 种货币',
      'zh_Hant': '3種貨幣',
    },
    'r04m9nxs': {
      'en': 'My Bank',
      'ar': 'بنكي',
      'zh_Hans': '我的银行',
      'zh_Hant': '我的銀行',
    },
    's56t3xya': {
      'en': 'Activity',
      'ar': 'نشاط',
      'zh_Hans': '活动',
      'zh_Hant': '活動',
    },
    '8nac51xz': {
      'en': 'Transfer',
      'ar': 'تحويل',
      'zh_Hans': '转移',
      'zh_Hant': '轉移',
    },
    'vewa5op5': {
      'en': 'Bitcoin',
      'ar': 'بيتكوين',
      'zh_Hans': '比特币',
      'zh_Hant': '比特幣',
    },
    '9oun2uok': {
      'en': '\$00.00',
      'ar': '00.00 دولار',
      'zh_Hans': '\$00.00',
      'zh_Hant': '\$00.00',
    },
    'yla7uncg': {
      'en': '32% of portfolio',
      'ar': '32% من المحفظة',
      'zh_Hans': '投资组合的32%',
      'zh_Hant': '投資組合的 32%',
    },
    '7hsm7t9z': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'opob20j8': {
      'en': 'ETH',
      'ar': 'إيثريوم',
      'zh_Hans': '以太坊',
      'zh_Hant': '以太坊',
    },
    'fi3cleyj': {
      'en': '\$00.00',
      'ar': '00.00 دولار',
      'zh_Hans': '\$00.00',
      'zh_Hant': '\$00.00',
    },
    '606emxw1': {
      'en': '40% of portfolio',
      'ar': '40% من المحفظة',
      'zh_Hans': '投资组合的40%',
      'zh_Hant': '投資組合的 40%',
    },
    'qx0ykpbm': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'l2io5lul': {
      'en': 'FGOLD',
      'ar': 'فجولد',
      'zh_Hans': '金牌',
      'zh_Hant': '福金',
    },
    'krsyyttw': {
      'en': '\$00.00',
      'ar': '00.00 دولار',
      'zh_Hans': '\$00.00',
      'zh_Hant': '\$00.00',
    },
    '4mvfe3pe': {
      'en': '40% of portfolio',
      'ar': '40% من المحفظة',
      'zh_Hans': '投资组合的40%',
      'zh_Hant': '投資組合的 40%',
    },
    '6cm4jjje': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'xb0zqloz': {
      'en': 'ETH',
      'ar': 'إيثريوم',
      'zh_Hans': '以太坊',
      'zh_Hant': '以太坊',
    },
    'kff8mhok': {
      'en': '\$00.00',
      'ar': '00.00 دولار',
      'zh_Hans': '\$00.00',
      'zh_Hant': '\$00.00',
    },
    'coooiajr': {
      'en': '40% of portfolio',
      'ar': '40% من المحفظة',
      'zh_Hans': '投资组合的40%',
      'zh_Hant': '投資組合的 40%',
    },
    'm9o6dl4k': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'vox9t1s0': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // MY_CardCopy
  {
    '3oex83e2': {
      'en': 'Wallet Balance',
      'ar': 'رصيد المحفظة',
      'zh_Hans': '钱包余额',
      'zh_Hant': '錢包餘額',
    },
    'hp1zxnee': {
      'en': '\$313,354,873.93',
      'ar': '313,354,873.93 دولار',
      'zh_Hans': '\$313,354,873.93',
      'zh_Hant': '\$313,354,873.93',
    },
    '3juac6ob': {
      'en': '4 currencies',
      'ar': '4 عملات',
      'zh_Hans': '4 种货币',
      'zh_Hant': '4種貨幣',
    },
    '2ppeihh9': {
      'en': 'BTC (5167.00)',
      'ar': 'بيتكوين (5167.00)',
      'zh_Hans': 'BTC (5167.00)',
      'zh_Hant': 'BTC (5167.00)',
    },
    '30l2412h': {
      'en': '≈\$310,624,588.58',
      'ar': 'حوالي 310,624,588.58 دولار',
      'zh_Hans': '≈310,624,588.58美元',
      'zh_Hant': '≈\$310,624,588.58',
    },
    'pon03b8t': {
      'en': '99.13% >>',
      'ar': '99.13% >>',
      'zh_Hans': '99.13% >>',
      'zh_Hant': '99.13% >>',
    },
    '3uxixuqr': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'cvqqm5yl': {
      'en': 'ETH (0.00)',
      'ar': 'إيثريوم (0.00)',
      'zh_Hans': 'ETH（0.00）',
      'zh_Hant': 'ETH (0.00)',
    },
    'q0cc39mt': {
      'en': '≈\$0.00',
      'ar': '≈0.00 دولار',
      'zh_Hans': '≈\$0.00',
      'zh_Hant': '≈\$0.00',
    },
    '6ctwlcdz': {
      'en': '0.00% >>',
      'ar': '0.00% >>',
      'zh_Hans': '0.00% >>',
      'zh_Hant': '0.00%>>',
    },
    'n3v8gy0i': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'ijyylobi': {
      'en': 'FGOLD (0.00)',
      'ar': 'فجولد (0.00)',
      'zh_Hans': 'FGOLD (0.00)',
      'zh_Hant': 'FGOLD (0.00)',
    },
    '0k6ra05s': {
      'en': '≈\$0.00',
      'ar': '≈0.00 دولار',
      'zh_Hans': '≈\$0.00',
      'zh_Hant': '≈\$0.00',
    },
    'gztv8rf9': {
      'en': '0.00% >>',
      'ar': '0.00% >>',
      'zh_Hans': '0.00% >>',
      'zh_Hant': '0.00% >>',
    },
    'xedrr7m3': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '58sonjg0': {
      'en': 'USDT(OMNI) (2,730,285)',
      'ar': '(2,730,285) USDT(OMNI)',
      'zh_Hans': 'USDT(OMNI)（2,730,285）',
      'zh_Hant': 'USDT(OMNI) (2,730,285)',
    },
    'v7gokx2b': {
      'en': '≈\$2,730,285.35',
      'ar': 'حوالي 2,730,285.35 دولار',
      'zh_Hans': '≈\$2,730,285.35',
      'zh_Hant': '≈\$2,730,285.35',
    },
    'x1p2h1mh': {
      'en': '0.87% >>',
      'ar': '0.87% >>',
      'zh_Hans': '0.87% >>',
      'zh_Hant': '0.87% >>',
    },
    'l3645yg3': {
      'en': ' ',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'p5kl6a40': {
      'en': '•',
      'ar': '•',
      'zh_Hans': '•',
      'zh_Hant': '•',
    },
  },
  // BTCreceipt
  {
    '37evv7za': {
      'en': 'Receipt&Payment',
      'ar': 'الاستلام والدفع',
      'zh_Hans': '收款&付款',
      'zh_Hant': '收款&付款',
    },
    'a1i0ljkv': {
      'en': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
      'ar': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
      'zh_Hans': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
      'zh_Hant': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
    },
    '3yi9fwtu': {
      'en':
          'Note: This address only supports transaction about BTC, please do not use in other coin.',
      'ar':
          'ملحوظة: هذا العنوان يدعم فقط المعاملات المتعلقة بـ BTC، يرجى عدم استخدامه في عملة أخرى.',
      'zh_Hans': '注意：该地址仅支持BTC交易，请勿使用其他币种。',
      'zh_Hant': '注意：此地址僅支援BTC交易，請勿使用其他幣種。',
    },
    's5sv586m': {
      'en': 'B-Wallet',
      'ar': 'محفظة NXTT',
      'zh_Hans': 'B-Wallet',
      'zh_Hant': 'NXTT錢包',
    },
    'hi76zons': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    'a7uw7b30': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // ETHreceipt
  {
    'j0qrzv7t': {
      'en': 'Receipt&Payment',
      'ar': 'الاستلام والدفع',
      'zh_Hans': '收款&付款',
      'zh_Hant': '收款&付款',
    },
    'iy2lfkvd': {
      'en': '0x2aa23cac0b7cfab66b157c7940764404c48b7cf1',
      'ar': '0x2aa23cac0b7cfab66b157c7940764404c48b7cf1',
      'zh_Hans': '0x2aa23cac0b7cfab66b157c7940764404c48b7cf1',
      'zh_Hant': '0x2aa23cac0b7cfab66b157c7940764404c48b7cf1',
    },
    'mhohdfnk': {
      'en':
          'Note: This address only supports transaction about ETH, please do not use in other coin.',
      'ar':
          'ملحوظة: هذا العنوان يدعم فقط المعاملات الخاصة بـ ETH، يرجى عدم استخدامه في عملة أخرى.',
      'zh_Hans': '注意：该地址仅支持ETH交易，请勿使用其他币种。',
      'zh_Hant': '注意：此地址僅支援ETH交易，請勿使用其他幣種。',
    },
    '15jlvqis': {
      'en': 'B-Wallet',
      'ar': 'محفظة NXTT',
      'zh_Hans': 'B-Wallet',
      'zh_Hant': 'NXTT錢包',
    },
    '4ray4fgo': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    'e3bvh0u2': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // FGOLDreceipt
  {
    '733aopwv': {
      'en': 'Receipt&Payment',
      'ar': 'الاستلام والدفع',
      'zh_Hans': '收款&付款',
      'zh_Hant': '收款&付款',
    },
    'whgh0vax': {
      'en': '0xfcha80593c682c6793ee2421c8899689cbfcd374553',
      'ar': '0xfcha80593c682c6793ee2421c8899689cbfcd374553',
      'zh_Hans': '0xfcha80593c682c6793ee2421c8899689cbfcd374553',
      'zh_Hant': '0xfcha80593c682c6793ee2421c8899689cbfcd374553',
    },
    'avczuvdf': {
      'en':
          'Note: This address only supports transaction about FGOLD, please do not use in other coin.',
      'ar':
          'ملحوظة: هذا العنوان يدعم فقط المعاملات الخاصة بـ FGOLD، يرجى عدم استخدامه في عملة أخرى.',
      'zh_Hans': '注意：该地址仅支持FGOLD的交易，请勿使用其他货币。',
      'zh_Hant': '注意：該地址僅支援FGOLD交易，請勿使用其他幣種。',
    },
    'u3v37ndx': {
      'en': 'B-Wallet',
      'ar': 'محفظة NXTT',
      'zh_Hans': 'B-Wallet',
      'zh_Hant': 'NXTT錢包',
    },
    'dgidxazd': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    'ltdaq37i': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // USDTreceipt
  {
    'mjv715hy': {
      'en': 'Receipt&Payment',
      'ar': 'الاستلام والدفع',
      'zh_Hans': '收款&付款',
      'zh_Hant': '收款&付款',
    },
    'osmwkkbd': {
      'en': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
      'ar': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
      'zh_Hans': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
      'zh_Hant': '1H2T3XabRtyJ4UWSWBQSP5Co9pBQ9d2K7K',
    },
    'rr6hnxzr': {
      'en':
          'Note: This address only supports transaction about USDT(OMNI), please do not use in other coin.',
      'ar':
          'ملاحظة: هذا العنوان يدعم فقط المعاملات الخاصة بـ USDT(OMNI)، يرجى عدم استخدامه في عملة أخرى.',
      'zh_Hans': '注意：该地址仅支持USDT（OMNI）交易，请勿使用其他币种。',
      'zh_Hant': '注意：此地址僅支援USDT(OMNI)交易，請勿使用其他幣種。',
    },
    'i3ghcbxf': {
      'en': 'B-Wallet',
      'ar': 'محفظة NXTT',
      'zh_Hans': 'B-Wallet',
      'zh_Hant': 'NXTT錢包',
    },
    'j4sen6c0': {
      'en': 'Please enter an amount',
      'ar': 'الرجاء إدخال المبلغ',
      'zh_Hans': '请输入金额',
      'zh_Hant': '請輸入金額',
    },
    '5zyqlvv5': {
      'en': 'Home',
      'ar': 'بيت',
      'zh_Hans': '首页',
      'zh_Hant': '首頁',
    },
  },
  // bookAppointment
  {
    'sfzj3riz': {
      'en': 'Book Appointment',
      'ar': 'حجز موعد',
      'zh_Hans': '预约',
      'zh_Hant': '預約',
    },
    'xukiv2ku': {
      'en': 'Start Date',
      'ar': 'اختر التاريخ',
      'zh_Hans': '选择日期',
      'zh_Hant': '選擇日期',
    },
    'n5xv86js': {
      'en': 'End Date',
      'ar': 'اختر التاريخ',
      'zh_Hans': '选择日期',
      'zh_Hant': '選擇日期',
    },
    'lpc88cht': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'zh_Hans': '取消',
      'zh_Hant': '取消',
    },
    'b5umyycx': {
      'en': 'Confirm',
      'ar': 'احجز الآن',
      'zh_Hans': '立即预订',
      'zh_Hant': '立即預訂',
    },
  },
  // bookingOld
  {
    '8laf5zmk': {
      'en': 'Book Appointment',
      'ar': 'حجز موعد',
      'zh_Hans': '预约',
      'zh_Hant': '預約',
    },
    'udwhsu8p': {
      'en':
          'Fill out the information below in order to book your appointment with our office.',
      'ar': 'قم بملء المعلومات أدناه لحجز موعدك مع مكتبنا.',
      'zh_Hans': '请填写以下信息以便与我们的办公室预约。',
      'zh_Hant': '填寫以下資訊以便與我們的辦公室預約。',
    },
    'm6f5lawq': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'zh_Hans': '电子邮件',
      'zh_Hant': '電子郵件',
    },
    'yz52729g': {
      'en': 'Booking For',
      'ar': 'الحجز ل',
      'zh_Hans': '預訂',
      'zh_Hant': '預訂',
    },
    'hdmqdmzq': {
      'en': 'Type of Appointment',
      'ar': 'نوع الموعد',
      'zh_Hans': '任命类型',
      'zh_Hant': '預約類型',
    },
    'stpxpct6': {
      'en': 'Doctors Visit',
      'ar': 'زيارة الأطباء',
      'zh_Hans': '医生访问',
      'zh_Hant': '醫生探訪',
    },
    'wvgk6obb': {
      'en': 'Routine Checkup',
      'ar': 'الفحص الروتيني',
      'zh_Hans': '例行检查',
      'zh_Hant': '常規檢查',
    },
    'xt7ujyt8': {
      'en': 'Scan/Update',
      'ar': 'مسح/تحديث',
      'zh_Hans': '扫描/更新',
      'zh_Hant': '掃描/更新',
    },
    'andpn0t0': {
      'en': 'What\'s the problem?',
      'ar': 'ما هي المشكلة؟',
      'zh_Hans': '有什么问题？',
      'zh_Hant': '有什麼問題嗎？',
    },
    'ycaso9dc': {
      'en': 'Choose Date',
      'ar': 'اختر التاريخ',
      'zh_Hans': '选择日期',
      'zh_Hant': '選擇日期',
    },
    '2pmd2p3w': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'zh_Hans': '取消',
      'zh_Hant': '取消',
    },
    '13j05r8j': {
      'en': 'Book Now',
      'ar': 'احجز الآن',
      'zh_Hans': '立即预订',
      'zh_Hant': '立即預訂',
    },
  },
  // editBooking
  {
    '6j668hma': {
      'en': 'Edit Appointment',
      'ar': 'تعديل الموعد',
      'zh_Hans': '編輯預約',
      'zh_Hant': '編輯預約',
    },
    'cbp936ta': {
      'en': 'Edit the fields below in order to change your appointment.',
      'ar': 'قم بتعديل الحقول أدناه لتتمكن من تغيير موعدك.',
      'zh_Hans': '编辑以下字段以更改您的预约。',
      'zh_Hant': '編輯以下欄位以更改您的預約。',
    },
    '6btfslje': {
      'en': 'Emails will be sent to:',
      'ar': 'سيتم إرسال رسائل البريد الإلكتروني إلى:',
      'zh_Hans': '电子邮件将发送至：',
      'zh_Hant': '電子郵件將發送至：',
    },
    'mhko6q8p': {
      'en': 'Booking For',
      'ar': 'الحجز ل',
      'zh_Hans': '預訂',
      'zh_Hant': '預訂',
    },
    'shqcgjqe': {
      'en': 'Type of Appointment',
      'ar': 'نوع الموعد',
      'zh_Hans': '任命类型',
      'zh_Hant': '預約類型',
    },
    '5ixhbnsd': {
      'en': 'Doctors Visit',
      'ar': 'زيارة الأطباء',
      'zh_Hans': '医生访问',
      'zh_Hant': '醫生探訪',
    },
    'db46hhfw': {
      'en': 'Routine Checkup',
      'ar': 'الفحص الروتيني',
      'zh_Hans': '例行检查',
      'zh_Hant': '常規檢查',
    },
    'e1zm6kzh': {
      'en': 'Scan/Update',
      'ar': 'مسح/تحديث',
      'zh_Hans': '扫描/更新',
      'zh_Hant': '掃描/更新',
    },
    'oy6qvd33': {
      'en': 'What\'s the problem?',
      'ar': 'ما هي المشكلة؟',
      'zh_Hans': '有什么问题？',
      'zh_Hant': '有什麼問題嗎？',
    },
    '9emhgrhs': {
      'en': 'Choose Date',
      'ar': 'اختر التاريخ',
      'zh_Hans': '选择日期',
      'zh_Hant': '選擇日期',
    },
    '2bzoinpy': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'zh_Hans': '取消',
      'zh_Hant': '取消',
    },
    'gjnq0j86': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'zh_Hans': '保存更改',
      'zh_Hant': '儲存變更',
    },
  },
  // pauseCard
  {
    'dt7m486y': {
      'en': 'Pause Card',
      'ar': 'بطاقة الإيقاف المؤقت',
      'zh_Hans': '暂停卡',
      'zh_Hant': '暫停卡',
    },
    '6edae99k': {
      'en': 'Are you sure you want to pause your card?',
      'ar': 'هل أنت متأكد أنك تريد إيقاف بطاقتك مؤقتًا؟',
      'zh_Hans': '您确定要暂停您的卡吗？',
      'zh_Hant': '您確定要暫停您的卡片嗎？',
    },
    'omtrfcm5': {
      'en': 'Nevermind',
      'ar': 'لا تهتم',
      'zh_Hans': '没关系',
      'zh_Hant': '沒關係',
    },
    'hw07mkb9': {
      'en': 'Yes, Pause',
      'ar': 'نعم، توقف مؤقتًا',
      'zh_Hans': '是的，暂停',
      'zh_Hant': '是的，暫停',
    },
  },
  // Miscellaneous
  {
    'lzyb73wy': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'kx9cdks4': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'efvtwj7k': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'ec5hfa1e': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'q5ljwvfo': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'j4rmwb3h': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '6ah1b18f': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '2kos1hen': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'gq08354y': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '62wq4hzz': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'j20zu31q': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'zf5z98dm': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '2pfv9d78': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'aox3s4fb': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'l8hv5a7z': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '4pjwb70a': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '0xlokf4y': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '8twlwiwt': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'ws3t1i7f': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '4rqsyo5x': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '179r7u6t': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'djgdgzzt': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '1i29b7xa': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'hrs7rwxv': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    't4xzlq9q': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    '513nj4m0': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
    'a1jxfgju': {
      'en': '',
      'ar': '',
      'zh_Hans': '',
      'zh_Hant': '',
    },
  },
].reduce((a, b) => a..addAll(b));
