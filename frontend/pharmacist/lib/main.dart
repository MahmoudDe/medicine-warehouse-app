import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medicine_warehouse/screens/Order_Screen.dart';
import 'package:medicine_warehouse/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'Provider/cart_model.dart';
import 'Provider/navigation_controller.dart';
import 'screens/Auth/Register.dart';
import 'screens/Auth/login.dart';
import 'screens/home_page.dart';
import 'screens/navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final storage = new FlutterSecureStorage();
  String? token = await storage.read(key: 'token');

  runApp(
      EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('ar', '')],
        path: 'assets/l10n', // <-- change the path to your path
        fallbackLocale: Locale('en', 'US'),
        child: MyApp(token: token),
      )
  );
}

class MyApp extends StatefulWidget {
  final String? token;

  MyApp({this.token});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    if (state != null) {
      state.setLocale(locale);
    }
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasArabicLocale(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  Locale _locale = Locale('en', 'US');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(systemNavigationBarColor: Colors.grey));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationController()),
        ChangeNotifierProvider(create: (context) => CartModel()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.orange,
              primaryColor: Colors.cyanAccent.shade700,
              canvasColor: Colors.white70,
              secondaryHeaderColor: Colors.orange,
              fontFamily: hasArabicLocale(context) ? 'Tajawal' : 'Avenir',
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                fontFamily: hasArabicLocale(context) ? 'Tajawal' : 'Avenir',
              ),
              child: child!,
            ),
          );
        },
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        home: widget.token == null ? LoginPage() : HomeScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomeScreen(),
          '/order': (context) => OrderPage(),
          '/main': (context) => const NavigationScreen(),
        },
      )
    );
  }
}
