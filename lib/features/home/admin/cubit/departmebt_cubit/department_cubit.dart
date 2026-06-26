import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtarib/features/home/admin/repo/admin_repo.dart';
import 'department_state.dart'; 
class DepartmentCubit extends Cubit<DepartmentState> {
  final AdminRepo _repo;
  DepartmentCubit(this._repo) : super(DepartmentInitial());

  Future<void> sendDepartment(String name) async {
    emit(DepartmentLoading()); 
    try {
      
      await _repo.addDepartment(name);
      emit(DepartmentSuccess()); 
    } catch (e) {
      emit(DepartmentError(e.toString())); 
    }
  }
// Future<void> fetchDepartments() async {
//     emit(DepartmentLoading());
//     final result = await _repo.getDepartments();
//     result.fold(
//       (error) => emit(DepartmentError(error)),
//       (list) => emit(DepartmentListLoaded(list)),
//     );
//   }
// Future<void> deleteDepartment(int id) async {
//     emit(DepartmentLoading());
//     final result = await _repo.deleteDepartment(id);
//     result.fold(
//       (error) => emit(DepartmentError(error)),
//       (success) => fetchDepartments(), 
//     );
//   }
}
  