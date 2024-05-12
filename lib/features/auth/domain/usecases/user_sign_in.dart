import 'package:blog_app_clean_tdd/core/error/failures.dart';
import 'package:blog_app_clean_tdd/core/usecase/usecase.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/entities/user.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UserCase<User, UserSIgnInParam> {
  final AuthRepository authRepository;

  const UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSIgnInParam params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSIgnInParam {
  final String email;
  final String password;

  const UserSIgnInParam({
    required this.email,
    required this.password,
  });
}
