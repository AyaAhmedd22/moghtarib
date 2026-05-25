import 'package:dio/dio.dart';

import '../entities/user.dart';
import '../failures/failure.dart';
import '../repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  const GetAllUsersUseCase({required this.repository});

  Future<GetAllUsersResult> execute({required String? token}) async {
    try {
      final users = await repository.getAllUsers(token: token);
      return GetAllUsersResult.success(users);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final msg =
          status != null ? 'Request failed ($status). Please try again.' : 'Network error. Please try again.';
      return GetAllUsersResult.failure(ServerFailure(msg));
    } catch (e) {
      return GetAllUsersResult.failure(NetworkFailure('Something went wrong. Please try again.'));
    }
  }
}

class GetAllUsersResult {
  final List<User>? users;
  final Failure? failure;

  const GetAllUsersResult._({this.users, this.failure});

  factory GetAllUsersResult.success(List<User> users) => GetAllUsersResult._(users: users);
  factory GetAllUsersResult.failure(Failure failure) => GetAllUsersResult._(failure: failure);

  bool get isSuccess => users != null;
}

