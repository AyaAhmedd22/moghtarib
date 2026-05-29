import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';
import '../../admin/cubit/sanaiee_cubit/sanaiee_cubit.dart';
import '../repo/student_repo.dart';
import '../../admin/view/sanaiee_tab_view.dart';
import '../../admin/repo/admin_repo.dart';
import '../cubit/all_apartment_cubit/all_apartment_cubit.dart';
import '../repo/student_repo.dart';
import '../view/all_apartment_tab_view.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء نسخة واحدة من الـ AdminRepo ليتشاركها الـ Cubits بدلاً من إنشاء نسختين منفصلتين
    final studentRepo = StudentRepo();
    final adminRepo = AdminRepo();
    return MultiBlocProvider(
      providers: [
         BlocProvider<AllApartmentCubit>(
          // هنا نقوم بحقن الـ SanaieeCubit واستدعاء fetchSanaiee() مباشرة لتبدأ البيانات بالتحميل فوراً
          create: (_) => AllApartmentCubit(studentRepo)..fetchAllApartment(),
        ),
        BlocProvider<SanaieeCubit>(
          // هنا نقوم بحقن الـ SanaieeCubit واستدعاء fetchSanaiee() مباشرة لتبدأ البيانات بالتحميل فوراً
          create: (_) => SanaieeCubit(adminRepo)..fetchSanaiee(), 
        ),
      
        //  BlocProvider<FavouriteCubit>(
        //   // هنا نقوم بحقن الـ SanaieeCubit واستدعاء fetchSanaiee() مباشرة لتبدأ البيانات بالتحميل فوراً
        //   create: (_) => SanaieeCubit(StudentRepo)..fetchSanaiee(), 
        // ),
      ],
      child: DefaultTabController(
        length: 2,
        child: BaseHomeScreen(
          drawerTitle: 'Student',
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
                   Tab(text: 'Apartment'),
                    Tab(text: 'Sanaiee'),
                    
                    // Tab(text: 'Favourite'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    ApartmentTabView(),
                    SanaieeTabView(), // 💡 الآن ستجد الـ Cubit الخاص بها وتعمل بسلام دون شاشة حمراء
                    // FavouriteTabView(),
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