import 'package:dio/dio.dart';

import '../models/user_dto.dart';

abstract class UserRemoteDataSource {
  Future<List<UserDto>> getAllUsers({required String? token});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  static const _endpoint = 'https://mo3tarib123.runasp.net/api/Account/GetAllUsers';

  @override
  Future<List<UserDto>> getAllUsers({required String? token}) async {
    final options = Options(
      headers: token == null || token.isEmpty
          ? null
          : <String, dynamic>{
              'Authorization': 'Bearer $token',
            },
      responseType: ResponseType.json,
    );

    final res = await dio.get(_endpoint, options: options);

    final data = res.data;
    if (data is List) {
      return data.map((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList();
    }

    if (data is Map<String, dynamic>) {
      // Some APIs wrap lists.
      final list = data['data'] ?? data['users'] ?? data['items'];
      if (list is List) {
        return list.map((e) => UserDto.fromJson(e as Map<String, dynamic>)).toList();
      }
    }

    return const [];
  }
}

