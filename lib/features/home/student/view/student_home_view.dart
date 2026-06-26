
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';
import '../../admin/cubit/sanaiee_cubit/sanaiee_cubit.dart';
import '../repo/student_repo.dart';
import '../../admin/view/sanaiee_tab_view.dart';
import '../../admin/repo/admin_repo.dart';
import '../cubit/all_apartment_cubit/all_apartment_cubit.dart';
import '../view/all_apartment_tab_view.dart';
import '../view/add_report_tab_view.dart';
import 'my_report_tab_view.dart';
import '../cubit/my_report_cubit/my_report_cubit.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final studentRepo = StudentRepo();
    final adminRepo = AdminRepo();
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllApartmentCubit>(
          create: (_) => AllApartmentCubit(studentRepo)..fetchAllApartment(),
        ),
        BlocProvider<SanaieeCubit>(
          create: (_) => SanaieeCubit(adminRepo)..fetchSanaiee(),
        ),
        
       BlocProvider(
        create: (context) => MyReportsCubit(studentRepo)..fetchMyReports(),
         child: const MyReportTabView(),
        )
      ],
      child: DefaultTabController(
        length: 4, 
        child: BaseHomeScreen(
          drawerTitle: 'Student',
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
                  indicatorWeight: 3,
                 
                  labelStyle: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                  ),
                  tabs: const [
                    Tab(text: 'Apartment'),
                    Tab(text: 'Sanaiee'),
                    Tab(text: 'Add Report'),
                    Tab(text: 'My Report'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ApartmentTabView(),
                    SanaieeTabView(),
                    AddReportTabView(),
                    MyReportTabView(),
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