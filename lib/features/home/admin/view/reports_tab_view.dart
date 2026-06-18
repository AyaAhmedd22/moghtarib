// import 'package:flutter/material.dart';

// class ReportsTabView extends StatelessWidget {
//   const ReportsTabView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Reports tab - not implemented yet',
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }

import '../repo/admin_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/reports_cubit/reports.state.dart';
import '../cubit/reports_cubit/reports_cubit.dart';

class ReportsTabView extends StatelessWidget {
  const ReportsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(AdminRepo())..fetchReports(),
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          int reportCount = (state is GetReportsSuccessState) ? state.reports.length : 0;

          return Column(
            children: [
              // الهيدر البنفسجي
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // تم استخدام Expanded لمنع الـ Overflow
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("All Reports", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("Review user reports and support requests.", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Icon(Icons.description, color: Colors.white, size: 20),
                          Text("Total\n$reportCount", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // منطقة عرض البلاغات
              Expanded(
                child: _buildBody(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(ReportState state) {
    if (state is GetReportsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (state is GetReportsSuccessState) {
      if (state.reports.isEmpty) {
        return const Center(child: Text("No reports found", style: TextStyle(color: Colors.grey)));
      }

      return ListView.builder(
        itemCount: state.reports.length,
        itemBuilder: (context, index) {
          final report = state.reports[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(report.user?.userName ?? "Unknown"),
              // استبدلي السطر 107 بـ:
               subtitle: Text(report.text ?? "لا يوجد نص"),
              trailing: IconButton(
               icon: const Icon(Icons.chat_bubble_outline, color: Colors.green),
                onPressed: () {
                  AdminRepo().openWhatsApp(report.user?.whatsappNumber ?? "");
                },
              ),
            ),
          );
        },
      );
    }

    if (state is GetReportsErrorState) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
        )
      );
    }

    return const SizedBox();
  }
}