import 'package:blog_app_clean_tdd/core/theme/theme.dart';
import 'package:blog_app_clean_tdd/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_clean_tdd/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          userSignUp: UserSignUp(
            AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(
                supabase.client,
              ),
            ),
          ),
        ),
      )
    ],
    child: const BlogApp(),
  ));
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
