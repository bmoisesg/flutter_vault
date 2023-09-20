import 'package:flutter/material.dart';
import 'package:flutter_gestor_contras/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFF7678)),
        useMaterial3: true,
        textTheme: GoogleFonts.dmSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const Login(),
    );
  }
}
