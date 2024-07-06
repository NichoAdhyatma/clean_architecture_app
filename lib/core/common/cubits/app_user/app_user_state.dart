part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserSignedIn extends AppUserState {
  final User user;

  AppUserSignedIn(this.user);
}

// core cannot depend on features
// other features can depend on core