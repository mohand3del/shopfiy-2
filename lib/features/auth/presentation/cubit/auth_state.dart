import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// ─── Initial ─────────────────────────────────────────────────────────────────
class AuthInitial extends AuthState {
  const AuthInitial();
}

// ─── Loading ─────────────────────────────────────────────────────────────────
class AuthLoading extends AuthState {
  const AuthLoading();
}

// ─── Success ─────────────────────────────────────────────────────────────────
class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

// ─── Failure ─────────────────────────────────────────────────────────────────
class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
