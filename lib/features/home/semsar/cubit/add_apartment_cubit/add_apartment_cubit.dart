import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/add_apartment_model.dart';
import '../../repo/add_apartment_repo.dart'; // تأكد من مسار الـ Repo عندك
import 'add_apartment_state.dart';
class ApartmentCubit extends Cubit<ApartmentState> {
  final ApartmentRepo apartmentRepo;

  ApartmentCubit(this.apartmentRepo) : super(ApartmentInitial());

  // ➕ دالة إضافة شقة جديدة (زي ما هي بدون تغيير)
  Future<void> addApartment({
    required AddApartmentModel apartment,
    required File? baseImage,
    required List<File> additionalImages,
  }) async {
    emit(ApartmentLoading());

    try {
      final response = await apartmentRepo.addApartment(
        apartment: apartment,
        baseImage: baseImage,
        additionalImages: additionalImages,
      );  

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(ApartmentAddSuccess());
      } else {
        emit(ApartmentError("Failed to add apartment${response.statusMessage}"));
      }
    } catch (error) {
      String errorMessage = error.toString();
      if (errorMessage.startsWith("Exception: ")) {
        errorMessage = errorMessage.replaceFirst("Exception: ", "");
      }
      emit(ApartmentError(errorMessage));
    }
  }

 // 🎯 دالة تعديل الشقة جوه الكيوبيت - نظيفة ومطابقة للـ Repo الجديد
  Future<void> updateApartment({    required AddApartmentModel apartment,
    File? baseImage,
  }) async {
    emit(ApartmentLoading());

    try {
      // بنمرر الكائن كامل والصورة علطول للـ Repo بدون تفكيك
      await apartmentRepo.updateApartment(
        apartment: apartment,
        baseImage: baseImage,
      );

      emit(ApartmentAddSuccess());
    } catch (error) {
      emit(ApartmentError(error.toString()));
    }
  }
}

























// // class ApartmentCubit extends Cubit<ApartmentState> {
// //   final ApartmentRepo apartmentRepo; // 💡 تأكد من اسم الكلاس المحدث ApartmentRepo

// //   ApartmentCubit(this.apartmentRepo) : super(ApartmentInitial());

// //   Future<void> addApartment({
// //     required AddApartmentModel apartment,
// //     required File? baseImage,
// //     required List<File> additionalImages,
// //   }) async {
// //     emit(ApartmentLoading());

// //     try {
// //       // ✅ استدعاء الدالة وانتظار الـ Response
// //       final response = await apartmentRepo.addApartment(
// //         apartment: apartment,
// //         baseImage: baseImage,
// //         additionalImages: additionalImages,
// //       );

// //       // التحقق من نجاح العملية بناءً على الـ StatusCode القادم من السيرفر
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         emit(ApartmentAddSuccess());
// //       } else {
// //         emit(ApartmentError("Failed to add apartment: ${response.statusMessage}"));
// //       }
// //     } catch (error) {
// //       // ✅ هنا يتم التقاط نص الخطأ المنسق القادم من دالة _handleDioError في الـ Repo
// //       emit(ApartmentError(error.toString()));
// //     }
// //   }
// // }

// // class ApartmentCubit extends Cubit<ApartmentState> {
// //   final ApartmentRepo apartmentRepo;

// //   ApartmentCubit(this.apartmentRepo) : super(ApartmentInitial());

// //   Future<void> addApartment({
// //     required AddApartmentModel apartment,
// //     required File? baseImage,
// //     required List<File> additionalImages,
// //   }) async {
// //     emit(ApartmentLoading());

// //     try {
      
// //       final response = await apartmentRepo.addApartment(
// //         apartment: apartment,
// //         baseImage: baseImage,
// //         additionalImages: additionalImages,
// //       );  
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         emit(ApartmentAddSuccess());
// //       } else {
// //         emit(ApartmentError("فشل في إضافة الشقة: ${response.statusMessage}"));
// //       }
// //     } catch (error) {
     
// //       String errorMessage = error.toString();
// //       if (errorMessage.startsWith("Exception: ")) {
// //         errorMessage = errorMessage.replaceFirst("Exception: ", "");
// //       }
      
// //       emit(ApartmentError(errorMessage));
// //     }
// //   }
// // }

// class ApartmentCubit extends Cubit<ApartmentState> {
//   final ApartmentRepo apartmentRepo;

//   ApartmentCubit(this.apartmentRepo) : super(ApartmentInitial());

//   Future<void> addApartment({
//     required AddApartmentModel apartment,
//     required File? baseImage,
//     required List<File> additionalImages,
//   }) async {
//     emit(ApartmentLoading());

//     try {
//       // 🚀 استدعاء دالة الـ Repo بالمعاملات الأصلية دون تغيير
//       // الـ Repo سيقوم تلقائياً بجلب التوكن من الكاش وإضافته للهيدر داخلياً
//       final response = await apartmentRepo.addApartment(
//         apartment: apartment,
//         baseImage: baseImage,
//         additionalImages: additionalImages,
//       );  

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         emit(ApartmentAddSuccess());
//       } else {
//         emit(ApartmentError("فشل في إضافة الشقة: ${response.statusMessage}"));
//       }
//     } catch (error) {
//       // معالجة نصوص الأخطاء وعرضها بشكل نظيف للمستخدم
//       String errorMessage = error.toString();
//       if (errorMessage.startsWith("Exception: ")) {
//         errorMessage = errorMessage.replaceFirst("Exception: ", "");
//       }
      
//       emit(ApartmentError(errorMessage));
//     }
//   }
// }