import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventou/views/onboarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventou ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0X0081889d)),
          textTheme: GoogleFonts.montserratTextTheme(),
          useMaterial3: true),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0X006b6ab3)),
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const OnboardingScreen(),
    );
  }
}
