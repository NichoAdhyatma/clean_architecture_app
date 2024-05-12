import 'package:blog_app_clean_tdd/features/auth/domain/entities/user.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app_clean_tdd/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
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
      (user) => emit(
        AuthSuccess(user),
      ),
    );
  }

  void _onAuthSignIn(
    AuthSignIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final response = await _userSignIn(
      UserSIgnInParam(
        email: event.email,
        password: event.password,
      ),
    );

    response.fold(
      (failure) => emit(
        AuthFailure(failure.message),
      ),
      (user) => emit(
        AuthSuccess(user),
      ),
    );
  }
}
