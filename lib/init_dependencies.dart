import 'package:blog_app_clean_tdd/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app_clean_tdd/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_clean_tdd/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/domain/repository/auth_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();

  await dotenv.load(fileName: ".env");

  final supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
        () =>
        AuthRemoteDataSourceImpl(
          serviceLocator(),
        ),
  );

  serviceLocator.registerFactory<AuthRepository>(
        () =>
        AuthRepositoryImpl(
          serviceLocator(),
        ),
  );

  serviceLocator.registerFactory(
        () =>
        UserSignUp(
          serviceLocator(),
        ),
  );
  serviceLocator.registerFactory(
        () =>
        UserSignIn(
          serviceLocator(),
        ),
  );

  serviceLocator.registerLazySingleton(
        () =>
        AuthBloc(
          userSignUp: serviceLocator(),
          userSignIn: serviceLocator(),
        ),
  );
}
