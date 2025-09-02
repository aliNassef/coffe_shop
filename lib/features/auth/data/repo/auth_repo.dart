import '../models/user_model.dart';

abstract class AuthRepo {
  Future<UserModel> singUp({required UserModel user, required String password});
  Future<UserModel> singIn({required String email, required String password});
}
