// abstract class DepartmentState {}

// class DepartmentInitial extends DepartmentState {}
// class DepartmentLoading extends DepartmentState {}
// class DepartmentSuccess extends DepartmentState {} 
// class DepartmentError extends DepartmentState {
//   final String error;
//   DepartmentError(this.error);
// }

import 'package:equatable/equatable.dart';
import '../../model/department_model.dart'; // تأكدي من المسار الصحيح للموديل

abstract class DepartmentState extends Equatable {
  const DepartmentState();
  
  @override
  List<Object> get props => [];
}

// الحالة الابتدائية
class DepartmentInitial extends DepartmentState {}

// حالة التحميل (لأي عملية: إضافة، جلب، أو حذف)
class DepartmentLoading extends DepartmentState {}

// حالة النجاح في الإضافة
class DepartmentSuccess extends DepartmentState {}

// حالة جلب البيانات بنجاح (هذه هي الحالة الجديدة للقائمة)
class DepartmentListLoaded extends DepartmentState {
  final List<DepartmentModel> departments;

  const DepartmentListLoaded(this.departments);

  @override
  List<Object> get props => [departments];
}

// حالة حدوث خطأ
class DepartmentError extends DepartmentState {
  final String error;

  const DepartmentError(this.error);

  @override
  List<Object> get props => [error];
}