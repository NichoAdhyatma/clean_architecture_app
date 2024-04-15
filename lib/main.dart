import 'package:blog_app_clean_tdd/core/theme/theme.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );

  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlogApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
