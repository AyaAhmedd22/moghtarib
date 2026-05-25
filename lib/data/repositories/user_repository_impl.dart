import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_dto.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  const UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getAllUsers({required String? token}) async {
    final dtos = await remoteDataSource.getAllUsers(token: token);
    return dtos
        .map(
          (e) => User(
            name: e.name,
            email: e.email,
            profileImageUrl: e.profileImageUrl,
          ),
        )
        .toList();
  }
}


