import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../repo/admin_repo.dart';
import 'users_state.dart';
import '../../model/user_model.dart';
class UsersCubit extends Cubit<UsersState> {
  final AdminRepo _repo;
  UsersCubit(this._repo) : super(UsersInitial());

  Future<void> fetchUsers({String? searchText}) async {
    emit(UsersLoading());
    final result = await _repo.getAllUsers(searchText: searchText);

    result.fold(
      (error) => emit(UsersError(error)),
      (users) => emit(UsersLoaded(users)),
    );
  }
// 📢 غيّري int إلى String هنا في البارامتر:
// Future<void> deleteUser({required String userId}) async {
//   final current = state;
//   if (current is! UsersLoaded) return;

//   final List<UserModel> currentUsers = List.from(current.users);

//   // تمرير الـ String userId بنجاح إلى الـ Repo بدون أخطاء
//   final result = await _repo.deleteUser(userId: userId);

//   result.fold(
//     (error) => emit(UsersError(error)), // تأكدي من اسم الـ State عندك لو مختلف
//     (success) {
//       if (success) {
//         // حذف المستخدم محلياً من القائمة بعد نجاح السيرفر
//         currentUsers.removeWhere((user) => user.id == userId);
//         emit(UsersLoaded(currentUsers));
//       }
//     },
//   );
// }
Future<void> deleteUser({required String userId}) async {
  // 1. التأكد من أن القائمة محملة حالياً قبل الحذف
  final current = state;
  if (current is! UsersLoaded) return;

  // 2. إنشاء نسخة من القائمة الحالية لتعديلها
  final List<UserModel> currentUsers = List.from(current.users);

  // 3. إرسال طلب الحذف للـ Repo
  final result = await _repo.deleteUser(userId: userId);

  result.fold(
    (error) {
      // إظهار الخطأ في حال فشل الحذف من السيرفر
      emit(UsersError(error));
    },
    (success) {
      if (success) {
        // 4. حذف المستخدم محلياً من القائمة (باستخدام toString للمقارنة الآمنة)
        currentUsers.removeWhere((user) => user.id.toString() == userId.toString());
        
        // 5. إرسال الحالة الجديدة لتحديث الشاشة فوراً
        emit(UsersLoaded(currentUsers));
      }
    },
  );
}



}