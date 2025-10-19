import 'package:flutter/material.dart';
import 'package:mantra_application/common/style/theme/mantra_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MantraTheme.lightTheme,
      darkTheme: MantraTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
