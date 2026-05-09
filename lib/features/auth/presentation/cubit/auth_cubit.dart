import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(const AuthInitial());

  // ─── Sign In ─────────────────────────────────────────────────────────────
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final (user, failure) = await signInUseCase(
      email: email,
      password: password,
    );

    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthSuccess(user!));
    }
  }

  // ─── Sign Up ─────────────────────────────────────────────────────────────
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final  (user, failure) = await signUpUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthSuccess(user!));
    }
  }

  // ─── Reset to initial ────────────────────────────────────────────────────
  void reset() => emit(const AuthInitial());
}
