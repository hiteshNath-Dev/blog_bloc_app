import 'package:blog_bloc_app/core/theme/palette.dart';
import 'package:blog_bloc_app/core/theme/theme.dart';
import 'package:blog_bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_bloc_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
