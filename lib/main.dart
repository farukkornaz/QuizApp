import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; // core flutter's material app
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:quiz_test_app/bindings/essential_binding.dart';
import 'components/root.dart';

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


 //List<Map<String, dynamic>> questions = allQuestions;

  /*var db = FirebaseFirestore.instance;
  final snapshot = await db.collection("category").get();

  final docs = snapshot.docs;
  print("dokümanlar:::::::::::::::::::::::::::::::::::::::::::::");
  for(int i = 0; i<docs.length; i++){
    print(docs[i].toString());
  }print("end");*/

  /*for(int i = 0; i<10; i++){
    db.collection("questions").add(questions[i]);
  }*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final ThemeData _theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Quicksand',
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.fromLTRB(10, 17, 10, 17),
      labelStyle: TextStyle(color: Colors.black87),
      hintStyle: TextStyle(color: Colors.grey),
      suffixStyle: TextStyle(color: Colors.black87),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.purple,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.purple,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 14),
      titleLarge: TextStyle(fontSize: 12),
      /*headline6: TextStyle(fontSize: 12),
      headline5: TextStyle(fontSize: 14),*/
    ).apply(
      bodyColor: Colors.black87,
      displayColor: Colors.black87,
      fontFamily: 'Quicksand',
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
    ),
    iconTheme: const IconThemeData(
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', ''),
        Locale('en', ''),
      ],
      theme: _theme.copyWith(
        colorScheme: _theme.colorScheme.copyWith(
          secondary: Colors.purpleAccent[100],
        ),
      ),
      initialBinding: EssentialBinding(),
      defaultTransition: Transition.cupertino,
      // page change effect
      transitionDuration: const Duration(milliseconds: 150),
      // page change speed
      home: Root(),
    );
  }
}
