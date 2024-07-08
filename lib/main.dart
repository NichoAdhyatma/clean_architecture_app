import 'package:blog_app_clean_tdd/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app_clean_tdd/core/theme/theme.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app_clean_tdd/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app_clean_tdd/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app_clean_tdd/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BlogBloc>(),
        )
      ],
      child: const BlogApp(),
    ),
  );
}

class BlogApp extends StatefulWidget {
  const BlogApp({super.key});

  @override
  State<BlogApp> createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserSignIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlogApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.system,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserSignedIn;
        },
        builder: (context, isUserSignIn) {
          if (isUserSignIn) {
            return const BlogPage();
          }
          return const SignUpPage();
        },
      ),
    );
  }
}
