// import 'dart:io'; // 💡 مهم للتعامل مع ملفات الصور
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../add_apartment_cubit/add_apartment_state.dart';
// import '../../model/add_apartment_model.dart';
// import '../../repo/add_apartment_repo.dart';

// class ApartmentCubit extends Cubit<ApartmentState> {
//   final ApartmentRepo _repository;

//   ApartmentCubit(this._repository) : super(ApartmentInitial());

//   void fetchApartments() async {
//     emit(ApartmentLoading());
//     try {
//       final apartments = await _repository.getApartments();
//       emit(ApartmentFetchSuccess(apartments));
//     } catch (e) {
//       emit(ApartmentError(e.toString()));
//     }
//   }

//   // 💡 تحديث الدالة هنا لتستقبل الصور وتمررها للـ Repo
//   void addApartment({
//     required AddApartmentModel apartment,
//     File? baseImage,
//     List<File>? additionalImages,
//   }) async {
//     emit(ApartmentLoading());
//     try {
//       await _repository.addApartment(
//         apartment: apartment,
//         baseImage: baseImage,
//         additionalImages: additionalImages,
//       );
//       emit(ApartmentAddSuccess());
//       fetchApartments(); // تحديث القائمة فوراً بعد النجاح
//     } catch (e) {
//       emit(ApartmentError(e.toString()));
//     }
//   }
// }

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/add_apartment_model.dart';
import '../../repo/add_apartment_repo.dart'; // تأكد من مسار الـ Repo عندك
import 'add_apartment_state.dart';

class ApartmentCubit extends Cubit<ApartmentState> {
  final ApartmentRepo apartmentRepo; // 💡 تأكد من اسم الكلاس المحدث ApartmentRepo

  ApartmentCubit(this.apartmentRepo) : super(ApartmentInitial());

  Future<void> addApartment({
    required AddApartmentModel apartment,
    required File? baseImage,
    required List<File> additionalImages,
  }) async {
    emit(ApartmentLoading());

    try {
      // ✅ استدعاء الدالة وانتظار الـ Response
      final response = await apartmentRepo.addApartment(
        apartment: apartment,
        baseImage: baseImage,
        additionalImages: additionalImages,
      );

      // التحقق من نجاح العملية بناءً على الـ StatusCode القادم من السيرفر
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ApartmentAddSuccess());
      } else {
        emit(ApartmentError("Failed to add apartment: ${response.statusMessage}"));
      }
    } catch (error) {
      // ✅ هنا يتم التقاط نص الخطأ المنسق القادم من دالة _handleDioError في الـ Repo
      emit(ApartmentError(error.toString()));
    }
  }
}