import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers({required String? token});
}

