import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/datasources/user_remote_datasource.dart';
import '../../data/http/dio_client.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/get_all_users.dart';
import '../state/users_home_controller.dart';
import '../widgets/user_card.dart';


class UsersHomeScreen extends StatefulWidget {
  const UsersHomeScreen({super.key});

  @override
  State<UsersHomeScreen> createState() => _UsersHomeScreenState();
}

class _UsersHomeScreenState extends State<UsersHomeScreen> {
  late final UsersHomeController controller;

  @override
  void initState() {
    super.initState();

    final dio = DioClient().dio;
    final remote = UserRemoteDataSourceImpl(dio: dio);
    final repo = UserRepositoryImpl(remoteDataSource: remote);
    final usecase = GetAllUsersUseCase(repository: repo);

    controller = UsersHomeController(
      getAllUsersUseCase: usecase,
      secureStorage: const FlutterSecureStorage(),
    );

    _load();
  }

  Future<void> _load() async {
    setState(() {});
    await controller.load();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _refresh() async {
    await controller.refresh();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                Text(
                  'Users',
                  style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'All registered users from the API.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                if (controller.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (controller.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: _ErrorState(
                      message: controller.errorMessage!,
                      onRetry: _load,
                    ),
                  )
                else if (controller.users.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: _EmptyState(),
                  )
                else
                  ...List.generate(
                    controller.users.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: index == controller.users.length - 1 ? 0 : 12),
                      child: UserCard(user: controller.users[index]),
                    ),
                  ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }

}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Failed to load users',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
        const SizedBox(height: 14),
        FilledButton.tonal(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No users found',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          'Try pulling to refresh.',
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

