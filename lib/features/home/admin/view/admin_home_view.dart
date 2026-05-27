import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';

import '../repo/admin_repo.dart';
import '../cubit/users_cubit/users_cubit.dart';

import '../view/users_tab_view.dart';
import '../view/sanaiee_tab_view.dart';
import '../view/reports_tab_view.dart';
class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ✨ تم تعديل هذا السطر لإرسال الـ repo كـ positional parameter مباشرة
      create: (_) => UsersCubit(AdminRepo()), 
      child: DefaultTabController(
        length: 3,
        child: BaseHomeScreen(
          drawerTitle: 'Admin',
          onLogout: null,
          body: Column(
            children: [
              Material(
                color: AppColors.scaffoldBackground,
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.7),
                  indicatorColor: Colors.white,
                  tabs: const [
                    Tab(text: 'Users'),
                    Tab(text: 'Sanaiee'),
                    Tab(text: 'Reports'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    UsersTabView(),
                    SanaieeTabView(),
                    ReportsTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}