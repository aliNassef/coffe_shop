part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => [message];
}

final class AuthSuccess extends AuthState {
  final UserRole role;
  const AuthSuccess(this.role);
  @override
  List<Object> get props => [role];
}
