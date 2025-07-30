import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? name = prefs.getString('username');

  runApp(MyApp(name: name));
}

class MyApp extends StatelessWidget {
  final String? name;

  MyApp({this.name});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenangos App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF3E9DC),
        primaryColor: Color(0xFF8C4C2F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF8C4C2F),
          primary: Color(0xFF8C4C2F),
          secondary: Color(0xFFD1495B),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF8C4C2F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD1495B),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: name != null ? HomeScreen(name: name!) : LoginScreen(),
    );
  }
}
