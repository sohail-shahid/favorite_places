import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.white,
  // background: Colors.grey,
);

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.black,
  //background: Colors.black,
);

final lightTextTheme = GoogleFonts.ubuntuCondensedTextTheme().copyWith(
  titleSmall: GoogleFonts.ubuntuCondensed().copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  titleMedium: GoogleFonts.ubuntuCondensed().copyWith(
    fontWeight: FontWeight.bold,
  ),
  titleLarge: GoogleFonts.ubuntuCondensed().copyWith(
    fontWeight: FontWeight.bold,
  ),
);

final darkTextTheme = GoogleFonts.ubuntuCondensedTextTheme().copyWith(
  titleSmall: GoogleFonts.ubuntuCondensed().copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleMedium: GoogleFonts.ubuntuCondensed().copyWith(
    fontWeight: FontWeight.bold,
  ),
  titleLarge: GoogleFonts.ubuntuCondensed().copyWith(
    fontWeight: FontWeight.bold,
  ),
);

final lightTheme = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  textTheme: lightTextTheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: lightColorScheme.background,
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: darkColorScheme,
  textTheme: darkTextTheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: Colors.black,
  ),
  scaffoldBackgroundColor: darkColorScheme.background,
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Places'),
        ),
        body: const Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
