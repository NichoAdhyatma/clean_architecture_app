import 'package:blog_app_clean_tdd/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app_clean_tdd/core/common/entities/user.dart';
import 'package:blog_app_clean_tdd/core/usecase/usecase.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => emit(
        AuthLoading(),
      ),
    );
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserSignIn>(_isUserSignIn);
  }

  void _isUserSignIn(
    AuthIsUserSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _currentUser(NoParams());
    response.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(
        user,
        emit,
      ),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (user) => _emitAuthSuccess(
        user,
        emit,
      ),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final response = await _userSignIn(
      UserSignInParam(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (user) => _emitAuthSuccess(
        user,
        emit,
      ),
    );
  }

  void _emitAuthSuccess(
    User user,
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
