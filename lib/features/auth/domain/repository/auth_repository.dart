import 'package:blog_app_clean_tdd/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import 'package:blog_app_clean_tdd/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
