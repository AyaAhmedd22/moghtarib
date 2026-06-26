

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtarib/features/home/admin/cubit/departmebt_cubit/department_cubit.dart';
import 'package:moghtarib/features/home/admin/view/add_department_tab_view.dart';

import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';

import '../repo/admin_repo.dart';
import '../cubit/users_cubit/users_cubit.dart';
import '../cubit/sanaiee_cubit/sanaiee_cubit.dart'; // 💡 تأكد من إضافة الـ import الخاص بالـ SanaieeCubit

import '../view/users_tab_view.dart';
import '../view/sanaiee_tab_view.dart';
import '../view/reports_tab_view.dart';
import '../cubit/reports_cubit/reports_cubit.dart';
class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

 @override
Widget build(BuildContext context) {
  final adminRepo = AdminRepo(); 

  return MultiBlocProvider(
    providers: [
      BlocProvider<UsersCubit>(create: (_) => UsersCubit(adminRepo)),
      BlocProvider<SanaieeCubit>(create: (_) => SanaieeCubit(adminRepo)..fetchSanaiee()),
      BlocProvider<ReportCubit>(create: (_) => ReportCubit(adminRepo)..fetchReports()),
      BlocProvider<DepartmentCubit>(create: (_) => DepartmentCubit(adminRepo))
    ],
      child: DefaultTabController(
        length: 4,
        child: BaseHomeScreen(
          drawerTitle: 'Admin',
          onLogout: null,
          body: Column(
            children: [
              Material(
                color: AppColors.scaffoldBackground,
                child: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.7),
                  indicatorColor: Colors.white,
                  tabs: const [
                    Tab(text: 'Users'),
                    Tab(text: 'Sanaiee'),
                    Tab(text: 'Reports'),
                    Tab(text: 'Add Department'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    UsersTabView(),
                    SanaieeTabView(), // 💡 الآن ستجد الـ Cubit الخاص بها وتعمل بسلام دون شاشة حمراء
                    ReportsTabView(),
                    AddDepartmentTabView(),
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