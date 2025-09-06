import 'firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/auth/data/models/user_model.dart';

class FireauthHelper {
  final _instance = FirebaseAuth.instance;
  Future<UserModel> registerUser({
    required UserModel user,
    required String password,
  }) async {
    final cred = await _instance.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );

    final userModel = UserModel(
      id: cred.user!.uid,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      role: user.role,
    );

    await FirestoreHelper().addUser(userModel);

    return userModel;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        final user = await FirestoreHelper().getUserById(cred.user!.uid);
        return user;
      }
      return null;
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  String? getCurrentUserId() => _instance.currentUser?.uid;
}
