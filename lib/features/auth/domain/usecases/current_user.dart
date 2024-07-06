import 'package:blog_app_clean_tdd/core/common/entities/user.dart';
import 'package:blog_app_clean_tdd/core/error/failures.dart';
import 'package:blog_app_clean_tdd/core/usecase/usecase.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UserCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

