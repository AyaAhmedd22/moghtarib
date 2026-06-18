import '../reports_cubit/reports.state.dart';
import '../../repo/admin_repo.dart';
import '../../model/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ReportCubit extends Cubit<ReportState> {
  final AdminRepo adminRepo;
  ReportCubit(this.adminRepo) : super(ReportInitial());

  List<ReportModel> reports = [];

  void fetchReports() async {
    emit(GetReportsLoadingState());
    
    final result = await adminRepo.getAllReports();
    
    result.fold(
      (error) => emit(GetReportsErrorState(error)),
      (list) {
        reports = list;
        emit(GetReportsSuccessState(reports));
      },
    );
  }
}