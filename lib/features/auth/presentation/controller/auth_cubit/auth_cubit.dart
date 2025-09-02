import 'package:bloc/bloc.dart';
import 'package:coffe_shop/features/auth/data/models/user_model.dart';
import 'package:coffe_shop/features/auth/data/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.singIn(email: email, password: password);
      emit(AuthSuccess(user.role));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(UserModel user, String password) async {
    emit(AuthLoading());
    try {
      await _authRepo.singUp(user: user, password: password);
      emit(AuthSuccess(user.role));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
