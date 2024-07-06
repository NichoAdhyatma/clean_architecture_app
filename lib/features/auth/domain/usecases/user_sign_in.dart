import 'package:blog_app_clean_tdd/core/common/entities/user.dart';
import 'package:blog_app_clean_tdd/core/error/failures.dart';
import 'package:blog_app_clean_tdd/core/usecase/usecase.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements UserCase<User, UserSignInParam> {
  final AuthRepository authRepository;

  const UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParam params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParam {
  final String email;
  final String password;

  const UserSignInParam({
    required this.email,
    required this.password,
  });
}
