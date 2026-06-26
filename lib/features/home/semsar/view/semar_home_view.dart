import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtarib/features/home/semsar/view/semsar_apartment_tab_view.dart';
import '../cubit/add_apartment_cubit/add_apartment_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../presentation/views/base_home_screen.dart';
import '../repo/add_apartment_repo.dart';
import 'add_apartment_tab_view.dart'; 
class SemsarHomeView extends StatelessWidget {
  const SemsarHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final semsarRepo = ApartmentRepo();

    return BlocProvider<ApartmentCubit>(
      create: (_) => ApartmentCubit(semsarRepo),
      child: DefaultTabController(
        length: 2,
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
                    Tab(text: 'Add Apartment'), 
                    Tab(text: 'My Apartments'),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    AddApartmentTabView(), 
                    MyApartmentsScreen()
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