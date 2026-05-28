// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/utils/app_colors.dart';
// import '../../presentation/views/base_home_screen.dart';

// import '../repo/admin_repo.dart';
// import '../cubit/users_cubit/users_cubit.dart';

// import '../view/users_tab_view.dart';
// import '../view/sanaiee_tab_view.dart';
// import '../view/reports_tab_view.dart';
// class AdminHomeView extends StatelessWidget {
//   const AdminHomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       // ✨ تم تعديل هذا السطر لإرسال الـ repo كـ positional parameter مباشرة
//       create: (_) => UsersCubit(AdminRepo()), 
//       child: DefaultTabController(
//         length: 3,
//         child: BaseHomeScreen(
//           drawerTitle: 'Admin',
//           onLogout: null,
//           body: Column(
//             children: [
//               Material(
//                 color: AppColors.scaffoldBackground,
//                 child: TabBar(
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.white.withOpacity(0.7),
//                   indicatorColor: Colors.white,
//                   tabs: const [
//                     Tab(text: 'Users'),
//                     Tab(text: 'Sanaiee'),
//                     Tab(text: 'Reports'),
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 child: TabBarView(
//                   children: [
//                     UsersTabView(),
//                     SanaieeTabView(),
//                     ReportsTabView(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';

import '../repo/admin_repo.dart';
import '../cubit/users_cubit/users_cubit.dart';
import '../cubit/sanaiee_cubit/sanaiee_cubit.dart'; // 💡 تأكد من إضافة الـ import الخاص بالـ SanaieeCubit

import '../view/users_tab_view.dart';
import '../view/sanaiee_tab_view.dart';
import '../view/reports_tab_view.dart';
class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء نسخة واحدة من الـ AdminRepo ليتشاركها الـ Cubits بدلاً من إنشاء نسختين منفصلتين
    final adminRepo = AdminRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (_) => UsersCubit(adminRepo),
        ),
        BlocProvider<SanaieeCubit>(
          // هنا نقوم بحقن الـ SanaieeCubit واستدعاء fetchSanaiee() مباشرة لتبدأ البيانات بالتحميل فوراً
          create: (_) => SanaieeCubit(adminRepo)..fetchSanaiee(), 
        ),
      ],
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
                    SanaieeTabView(), // 💡 الآن ستجد الـ Cubit الخاص بها وتعمل بسلام دون شاشة حمراء
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