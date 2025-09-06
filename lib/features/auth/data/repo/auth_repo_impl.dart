import '../../../../core/helpers/fireauth_helper.dart';
import '../models/user_model.dart';

import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FireauthHelper _firebaseAuth;

  AuthRepoImpl({required FireauthHelper firebaseAuth})
    : _firebaseAuth = firebaseAuth;
  @override
  Future<UserModel> singIn({
    required String email,
    required String password,
  }) async {
    final user = await _firebaseAuth.loginUser(email, password);
    return user!;
  }

  @override
  Future<UserModel> singUp({
    required UserModel user,
    required String password,
  }) async {
    final userModel = await _firebaseAuth.registerUser(
      user: user,
      password: password,
    );
    return userModel;
  }
}
