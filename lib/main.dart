import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; // core flutter's material app
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/bindings/auth_binding.dart';

import 'components/root.dart';
import 'controllers/auth_controller.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDFXJd0_6ydGExtOzlH6lBZWEjfbRXocT4',
    appId: '1:573131445611:android:ad29f870a981780d4fa82e',
    messagingSenderId: '573131445611',
    projectId: 'quiz-test-app-1fd6c',
  ));

  runApp(MyApp()); // runs main class
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  ThemeData _theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Quicksand',
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.fromLTRB(10, 17, 10, 17),
      labelStyle: TextStyle(color: Colors.black87),
      hintStyle: TextStyle(color: Colors.grey),
      suffixStyle: TextStyle(color: Colors.black87),
      enabledBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.purple,
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.purple,
        ),
      ),
      errorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
    textTheme: TextTheme(
      headline5: TextStyle(fontSize: 14),
      headline6: TextStyle(fontSize: 12),
      /*headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),*/
    ).apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
      fontFamily: 'Quicksand',
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.purple.shade50),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(Colors.purple.shade200),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr', ''),
        const Locale('en', ''),
      ],
      theme: _theme.copyWith(
        colorScheme: _theme.colorScheme.copyWith(
          secondary: Colors.purpleAccent[100],
        ),
      ),
      initialBinding: AuthBinding(),
      defaultTransition: Transition.cupertino,
      // page change effect
      transitionDuration: Duration(milliseconds: 150),
      // page change speed
      home: Root(),
    );
  }
}
