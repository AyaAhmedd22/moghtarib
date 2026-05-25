import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user.dart';
import '../../domain/failures/failure.dart';
import '../../domain/usecases/get_all_users.dart';

class UsersHomeController {
  final GetAllUsersUseCase getAllUsersUseCase;
  final FlutterSecureStorage secureStorage;

  UsersHomeController({
    required this.getAllUsersUseCase,
    required this.secureStorage,
  });

  bool isLoading = false;
  String? errorMessage;
  List<User> users = const [];

  Future<void> load() async {
    isLoading = true;
    errorMessage = null;

    final token = await _readToken();

    final result = await getAllUsersUseCase.execute(token: token);
    if (result.isSuccess) {
      users = result.users ?? const [];
      errorMessage = null;
    } else {
      final Failure f = result.failure!;
      users = const [];
      errorMessage = f.message;
    }

    isLoading = false;
  }

  Future<void> refresh() async => load();

  Future<String?> _readToken() async {
    // Try multiple common keys.
    final t1 = await secureStorage.read(key: 'token');
    if (t1 != null && t1.isNotEmpty) return t1;

    final t2 = await secureStorage.read(key: 'accessToken');
    if (t2 != null && t2.isNotEmpty) return t2;

    return null;
  }
}

