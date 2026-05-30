
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/add_apartment_cubit/add_apartment_cubit.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../presentation/views/base_home_screen.dart';
// import '../repo/add_apartment_repo.dart';
// class SemsarHomeView extends StatelessWidget {
//   const SemsarHomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // إنشاء نسخة واحدة من الـ AdminRepo ليتشاركها الـ Cubits بدلاً من إنشاء نسختين منفصلتين
//     final semsarRepo = ApartmentRepo();

//     return BlocProvider<ApartmentCubit>(
//           create: (_) => ApartmentCubit(semsarRepo),
        
//       child: DefaultTabController(
//         length: 3,
//         child: BaseHomeScreen(
//           drawerTitle: 'Semsar',
//           onLogout: null,
//           body: Column(
//             children: [
//               Material(
//                 color: AppColors.scaffoldBackground,
//                 // child: TabBar(
//                 //   labelColor: Colors.white,
//                 //   unselectedLabelColor: Colors.white.withOpacity(0.7),
//                 //   indicatorColor: Colors.white,
//                 //   tabs: const [
//                 //     Tab(text: 'Users'),
//                 //     Tab(text: 'Sanaiee'),
//                 //     Tab(text: 'Reports'),
//                 //   ],
//                 // ),
//               ),
//               // const Expanded(
//               //   child: TabBarView(
//               //     children: [
//               //       UsersTabView(),
//               //       SanaieeTabView(), // 💡 الآن ستجد الـ Cubit الخاص بها وتعمل بسلام دون شاشة حمراء
//               //       ReportsTabView(),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/add_apartment_cubit/add_apartment_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';
import '../repo/add_apartment_repo.dart';
// قم بعمل import لملف الـ TabView هنا
import 'add_apartment_tab_view.dart'; 

class SemsarHomeView extends StatelessWidget {
  const SemsarHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // إنشاء نسخة واحدة من الـ Repo
    final semsarRepo = ApartmentRepo();

    return BlocProvider<ApartmentCubit>(
      create: (_) => ApartmentCubit(semsarRepo),
      child: DefaultTabController(
        length: 1, // تم تعديلها إلى 1 حالياً بناءً على التابات المتاحة عندك
        child: BaseHomeScreen(
          drawerTitle: 'Semsar',
          onLogout: null,
          body: Column(
            children: [
              Material(
                color: AppColors.scaffoldBackground,
                child: const TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Color(0xFF6F32E4),
                  tabs: [
                    Tab(text: 'Add Apartment'), // التاب الحالي الخاص بك
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    AddApartmentTabView(), // استدعاء الـ View الفعلي هنا ليقرأ الـ Cubit بسلام
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