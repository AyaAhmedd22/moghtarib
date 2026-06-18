import 'dart:io';
import 'package:dio/dio.dart';
import 'package:moghtarib/core/network/end_points.dart';
import '../model/add_apartment_model.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_keys.dart';

// class ApartmentRepo {
//   final Dio _dio;

//   ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
//     BaseOptions(
//       baseUrl: EndPoints.baseUrl, 
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );

  
//   Future<Response> addApartment({
//     required AddApartmentModel apartment,
//     File? baseImage,
//     List<File>? additionalImages,
//   }) async {
//     try {
      
//       final Map<String, dynamic> queryParams = {
//         'City': apartment.city,
//         'Village': apartment.village,
//         'Location': apartment.location,
//         'Price': apartment.price,
//         'NumOfRooms': apartment.numOfRooms,
//         'Type': apartment.type,
//         'address_Lat': apartment.addressLat, 
//         'address_Lon': apartment.addressLon, 
//         'IsRent': apartment.isRent,
//       };

//             final FormData formData = FormData();

      
//       if (baseImage != null) {
//         formData.files.add(
//           MapEntry(
//             'BaseImage', 
//             await MultipartFile.fromFile(
//               baseImage.path, 
//               filename: baseImage.path.split('/').last,
//             ),
//           ),
//         );
//       }

      
//       if (additionalImages != null && additionalImages.isNotEmpty) {
//         for (var file in additionalImages) {
//           formData.files.add(
//             MapEntry(
//               'Images', 
//               await MultipartFile.fromFile(
//                 file.path, 
//                 filename: file.path.split('/').last,
//               ),
//             ),
//           );
//         }
//       }

      
//       print("🚀 Requesting Endpoint: ${EndPoints.getApartment}");
//       print("🚀 Query Params Sent: $queryParams");

      
//       final response = await _dio.post(
//         EndPoints.postApartment, 
//         queryParameters: queryParams, 
//         data: formData,               
//       );

//       return response;
//     } on DioException catch (e) {
//       throw _handleDioError(e);
//     } catch (e) {
//       throw Exception('حدث خطأ غير متوقع: $e');
//     }
//   }

  
//   String _handleDioError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
//       case DioExceptionType.receiveTimeout:
//         return 'انتهت مهلة استقبال البيانات من السيرفر.';
//       case DioExceptionType.badResponse:
//         final statusCode = error.response?.statusCode;
//         String? serverMessage;

        
//         if (error.response?.data is Map<String, dynamic> || error.response?.data is Map) {
//           serverMessage = error.response?.data?['message'] ?? error.response?.data?['Message'];
//         } 
        
//         else if (error.response?.data is List) {
//           final listData = error.response?.data as List;
//           if (listData.isNotEmpty && listData.first is Map) {
//             serverMessage = listData.first['message'] ?? listData.first['Message'];
//           }
//         }

       
//         serverMessage ??= error.response?.statusMessage;

//         return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب (تأكد من الـ Endpoint)"}';
        
//       case DioExceptionType.connectionError:
//         return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
//       default:
//         return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
//     }
//   }
// }
//###################################################################################


class ApartmentRepo {
  final Dio _dio;

  ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl, 
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<Response> addApartment({
    required AddApartmentModel apartment,
    File? baseImage,
    List<File>? additionalImages,
  }) async {
    try {
      // 1️⃣ حياكة الـ Query Parameters للنصوص والأرقام كما طلبها السيرفر في الـ Swagger
      final Map<String, dynamic> queryParams = {
        'City': apartment.city,
        'Village': apartment.village,
        'Location': apartment.location,
        'Price': apartment.price.toInt(),          
        'NumOfRooms': apartment.numOfRooms,  
        'Type': apartment.type,              
        'address_Lat': apartment.addressLat, 
        'address_Lon': apartment.addressLon, 
        'IsRent': apartment.isRent,          
      };

      // 2️⃣ الـ FormData مخصص للصور فقط
      final FormData formData = FormData();

      if (baseImage != null) {
        formData.files.add(
          MapEntry(
            'BaseImage', 
            await MultipartFile.fromFile(
              baseImage.path, 
              filename: baseImage.path.split('/').last,
            ),
          ),
        );
      }

      if (additionalImages != null && additionalImages.isNotEmpty) {
        for (var file in additionalImages) {
          formData.files.add(
            MapEntry(
              'Images', 
              await MultipartFile.fromFile(
                file.path, 
                filename: file.path.split('/').last,
              ),
            ),
          );
        }
      }

      // 3️⃣ جلب التوكن بشكل آمن تماماً وتفادي خطأ الـ Object Casting
      // final dynamic rawToken = CacheHelper.getValue('token');
      // print("🚀 Raw Token Value from Cache: $rawToken"); // أضف هذا السطر
      // final String token = rawToken != null ? rawToken.toString() : '';

      // print("🚀 SENDING TO: ${EndPoints.baseUrl}${EndPoints.postApartment}");
      // print("🚀 AUTH TOKEN LENGTH: ${token.length}");

// تأكد من أن هذه القيمة هي فعلياً ما تم تخزينه
// الطريقة الصحيحة لتحويل الـ Object إلى String
final String? token = CacheHelper.getValue(CacheKeys.accessToken)?.toString();

print("🚀 التوكن المسترجع من الكاش: $token");

if (token == null || token.isEmpty) {
  // هنا يمكنك إضافة منطق لإجبار المستخدم على تسجيل الدخول مجدداً
  print("🚨 تحذير: التوكن فارغ أو غير موجود!");
}


      // 4️⃣ إرسال الطلب النهائي المدمج بالسيرفر أونلاين
      final response = await _dio.post(
        EndPoints.postApartment, 
        queryParameters: queryParams, // الحقول النصية في الـ URL
        data: formData,               // الصور في الـ Body
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
  if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
  'Accept': 'application/json',
},
        ),
      );

      return response;
    } on DioException catch (e) {
      print("🚨 FULL SERVER ERROR: ${e.response?.data}");
      print("🚨 STATUS CODE: ${e.response?.statusCode}");
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
      case DioExceptionType.receiveTimeout:
        return 'انتهت مهلة استقبال البيانات من السيرفر.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        String? serverMessage;

        if (error.response?.data is Map<String, dynamic> || error.response?.data is Map) {
          serverMessage = error.response?.data?['message'] ?? error.response?.data?['Message'];
        } 
        else if (error.response?.data is List) {
          final listData = error.response?.data as List;
          if (listData.isNotEmpty && listData.first is Map) {
            serverMessage = listData.first['message'] ?? listData.first['Message'];
          }
        }

        serverMessage ??= error.response?.statusMessage;

        return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب (تأكد من الـ Endpoint أو الـ Authorization)"}';
        
      case DioExceptionType.connectionError:
        return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
      default:
        return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
    }
  }
}

// class ApartmentRepo {
//   final Dio _dio;

//   ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
//     BaseOptions(
//       baseUrl: EndPoints.baseUrl, 
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );

  
//   Future<Response> addApartment({
//     required AddApartmentModel apartment,
//     File? baseImage,
//     List<File>? additionalImages,
//   }) async {
//     try {
      
//       final Map<String, dynamic> queryParams = {
//         'City': apartment.city,
//         'Village': apartment.village,
//         'Location': apartment.location,
//         'Price': apartment.price,
//         'NumOfRooms': apartment.numOfRooms,
//         'Type': apartment.type,
//         'address_Lat': apartment.addressLat, 
//         'address_Lon': apartment.addressLon, 
//         'IsRent': apartment.isRent,
//       };

//             final FormData formData = FormData();

      
//       if (baseImage != null) {
//         formData.files.add(
//           MapEntry(
//             'BaseImage', 
//             await MultipartFile.fromFile(
//               baseImage.path, 
//               filename: baseImage.path.split('/').last,
//             ),
//           ),
//         );
//       }

      
//       if (additionalImages != null && additionalImages.isNotEmpty) {
//         for (var file in additionalImages) {
//           formData.files.add(
//             MapEntry(
//               'Images', 
//               await MultipartFile.fromFile(
//                 file.path, 
//                 filename: file.path.split('/').last,
//               ),
//             ),
//           );
//         }
//       }

      
//       print("🚀 Requesting Endpoint: ${EndPoints.getApartment}");
//       print("🚀 Query Params Sent: $queryParams");

      
//       final response = await _dio.post(
//         EndPoints.postApartment, 
//         queryParameters: queryParams, 
//         data: formData,               
//       );

//       return response;
//     } on DioException catch (e) {
//       throw _handleDioError(e);
//     } catch (e) {
//       throw Exception('حدث خطأ غير متوقع: $e');
//     }
//   }

  
//   String _handleDioError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
//       case DioExceptionType.receiveTimeout:
//         return 'انتهت مهلة استقبال البيانات من السيرفر.';
//       case DioExceptionType.badResponse:
//         final statusCode = error.response?.statusCode;
//         String? serverMessage;

        
//         if (error.response?.data is Map<String, dynamic> || error.response?.data is Map) {
//           serverMessage = error.response?.data?['message'] ?? error.response?.data?['Message'];
//         } 
        
//         else if (error.response?.data is List) {
//           final listData = error.response?.data as List;
//           if (listData.isNotEmpty && listData.first is Map) {
//             serverMessage = listData.first['message'] ?? listData.first['Message'];
//           }
//         }

       
//         serverMessage ??= error.response?.statusMessage;

//         return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب (تأكد من الـ Endpoint)"}';
        
//       case DioExceptionType.connectionError:
//         return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
//       default:
//         return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
//     }
//   }
// }
//###################################################################################



// class ApartmentRepo {
//   final Dio _dio;

//   ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
//     BaseOptions(
//       baseUrl: EndPoints.baseUrl, 
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );

  
//   Future<Response> addApartment({
//     required AddApartmentModel apartment,
//     File? baseImage,
//     List<File>? additionalImages,
//   }) async {
//     try {
      
//       final Map<String, dynamic> queryParams = {
//         'City': apartment.city,
//         'Village': apartment.village,
//         'Location': apartment.location,
//         'Price': apartment.price,
//         'NumOfRooms': apartment.numOfRooms,
//         'Type': apartment.type,
//         'address_Lat': apartment.addressLat, 
//         'address_Lon': apartment.addressLon, 
//         'IsRent': apartment.isRent,
//       };

//             final FormData formData = FormData();

      
//       if (baseImage != null) {
//         formData.files.add(
//           MapEntry(
//             'BaseImage', 
//             await MultipartFile.fromFile(
//               baseImage.path, 
//               filename: baseImage.path.split('/').last,
//             ),
//           ),
//         );
//       }

      
//       if (additionalImages != null && additionalImages.isNotEmpty) {
//         for (var file in additionalImages) {
//           formData.files.add(
//             MapEntry(
//               'Images', 
//               await MultipartFile.fromFile(
//                 file.path, 
//                 filename: file.path.split('/').last,
//               ),
//             ),
//           );
//         }
//       }

      
//       print("🚀 Requesting Endpoint: ${EndPoints.getApartment}");
//       print("🚀 Query Params Sent: $queryParams");

      
//       final response = await _dio.post(
//         EndPoints.postApartment, 
//         queryParameters: queryParams, 
//         data: formData,               
//       );

//       return response;
//     } on DioException catch (e) {
//       throw _handleDioError(e);
//     } catch (e) {
//       throw Exception('حدث خطأ غير متوقع: $e');
//     }
//   }

  
//   String _handleDioError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
//       case DioExceptionType.receiveTimeout:
//         return 'انتهت مهلة استقبال البيانات من السيرفر.';
//       case DioExceptionType.badResponse:
//         final statusCode = error.response?.statusCode;
//         String? serverMessage;

        
//         if (error.response?.data is Map<String, dynamic> || error.response?.data is Map) {
//           serverMessage = error.response?.data?['message'] ?? error.response?.data?['Message'];
//         } 
        
//         else if (error.response?.data is List) {
//           final listData = error.response?.data as List;
//           if (listData.isNotEmpty && listData.first is Map) {
//             serverMessage = listData.first['message'] ?? listData.first['Message'];
//           }
//         }

       
//         serverMessage ??= error.response?.statusMessage;

//         return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب (تأكد من الـ Endpoint)"}';
        
//       case DioExceptionType.connectionError:
//         return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
//       default:
//         return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
//     }
//   }
// }
//###################################################################################


// class ApartmentRepo {
//   final Dio _dio;

//   ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
//     BaseOptions(
//       baseUrl: EndPoints.baseUrl, 
//       connectTimeout: const Duration(seconds: 10),
//       receiveTimeout: const Duration(seconds: 10),
//     ),
//   );

//   Future<Response> addApartment({
//     required AddApartmentModel apartment,
//     File? baseImage,
//     List<File>? additionalImages,
//   }) async {
//     try {
//       // 1️⃣ حياكة الـ Query Parameters للنصوص والأرقام كما طلبها السيرفر في الـ Swagger
//       final Map<String, dynamic> queryParams = {
//         'City': apartment.city,
//         'Village': apartment.village,
//         'Location': apartment.location,
//         'Price': apartment.price.toInt(),          
//         'NumOfRooms': apartment.numOfRooms,  
//         'Type': apartment.type,              
//         'address_Lat': apartment.addressLat, 
//         'address_Lon': apartment.addressLon, 
//         'IsRent': apartment.isRent,          
//       };

//       // 2️⃣ الـ FormData مخصص للصور فقط
//       final FormData formData = FormData();

//       if (baseImage != null) {
//         formData.files.add(
//           MapEntry(
//             'BaseImage', 
//             await MultipartFile.fromFile(
//               baseImage.path, 
//               filename: baseImage.path.split('/').last,
//             ),
//           ),
//         );
//       }

//       if (additionalImages != null && additionalImages.isNotEmpty) {
//         for (var file in additionalImages) {
//           formData.files.add(
//             MapEntry(
//               'Images', 
//               await MultipartFile.fromFile(
//                 file.path, 
//                 filename: file.path.split('/').last,
//               ),
//             ),
//           );
//         }
//       }

//       // 3️⃣ جلب التوكن بشكل آمن تماماً وتفادي خطأ الـ Object Casting
//       final dynamic rawToken = CacheHelper.getValue('token');
//       final String token = rawToken != null ? rawToken.toString() : '';

//       print("🚀 SENDING TO: ${EndPoints.baseUrl}${EndPoints.postApartment}");
//       print("🚀 AUTH TOKEN LENGTH: ${token.length}");

//       // 4️⃣ إرسال الطلب النهائي المدمج بالسيرفر أونلاين
//       final response = await _dio.post(
//         EndPoints.postApartment, 
//         queryParameters: queryParams, // الحقول النصية في الـ URL
//         data: formData,               // الصور في الـ Body
//         options: Options(
//           contentType: 'multipart/form-data',
//           headers: {
//             if (token.isNotEmpty) 'Authorization': 'Bearer $token',
//             'Accept': 'application/json',
//           },
//         ),
//       );

//       return response;
//     } on DioException catch (e) {
//       print("🚨 FULL SERVER ERROR: ${e.response?.data}");
//       print("🚨 STATUS CODE: ${e.response?.statusCode}");
//       throw _handleDioError(e);
//     } catch (e) {
//       throw Exception('حدث خطأ غير متوقع: $e');
//     }
//   }

//   String _handleDioError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
//       case DioExceptionType.receiveTimeout:
//         return 'انتهت مهلة استقبال البيانات من السيرفر.';
//       case DioExceptionType.badResponse:
//         final statusCode = error.response?.statusCode;
//         String? serverMessage;

//         if (error.response?.data is Map<String, dynamic> || error.response?.data is Map) {
//           serverMessage = error.response?.data?['message'] ?? error.response?.data?['Message'];
//         } 
//         else if (error.response?.data is List) {
//           final listData = error.response?.data as List;
//           if (listData.isNotEmpty && listData.first is Map) {
//             serverMessage = listData.first['message'] ?? listData.first['Message'];
//           }
//         }

//         serverMessage ??= error.response?.statusMessage;

//         return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب (تأكد من الـ Endpoint أو الـ Authorization)"}';
        
//       case DioExceptionType.connectionError:
//         return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
//       default:
//         return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
//     }
//   }
// }











// // class ApartmentRepo {
// //   final Dio _dio;

// //   ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
// //     BaseOptions(
// //       baseUrl: EndPoints.baseUrl, 
// //       connectTimeout: const Duration(seconds: 10),
// //       receiveTimeout: const Duration(seconds: 10),
// //     ),
// //   );

// //   /// ✅ دالة إضافة شقة جديدة متوافقة مع الـ Swagger (البيانات في الرابط والصور في الـ Body)
// // /// ✅ الدالة المحدثة لضبط حالة الأحرف للمتغيرات وفصل الصور عن النصوص
// //  /// ✅ الدالة النهائية المطابقة تماماً لتصميم السيرفر في الـ Swagger
// //   Future<Response> addApartment({
// //     required AddApartmentModel apartment,
// //     File? baseImage,
// //     List<File>? additionalImages,
// //   }) async {
// //     try {
// //       // 1. بناء الـ Query Parameters مع التدقيق الشديد في حالة الأحرف (مطابق للـ Swagger)
// //       final Map<String, dynamic> queryParams = {
// //         'City': apartment.city,
// //         'Village': apartment.village,
// //         'Location': apartment.location,
// //         'Price': apartment.price,
// //         'NumOfRooms': apartment.numOfRooms,
// //         'Type': apartment.type,
// //         'address_Lat': apartment.addressLat, // 👈 حرف L كبير وليس صغير
// //         'address_Lon': apartment.addressLon, // 👈 حرف L كبير وليس صغير
// //         'IsRent': apartment.isRent,
// //       };

// //       // 2. بناء الـ FormData للصور فقط في الـ Body
// //       final FormData formData = FormData();

// //       // إضافة الصورة الأساسية (Key: BaseImage)
// //       if (baseImage != null) {
// //         formData.files.add(
// //           MapEntry(
// //             'BaseImage', // 👈 حرف B كبير وحرف I كبير مطابق للـ Swagger
// //             await MultipartFile.fromFile(
// //               baseImage.path, 
// //               filename: baseImage.path.split('/').last,
// //             ),
// //           ),
// //         );
// //       }

// //       // إضافة الصور الإضافية المتعددة (Key: Images)
// //       if (additionalImages != null && additionalImages.isNotEmpty) {
// //         for (var file in additionalImages) {
// //           formData.files.add(
// //             MapEntry(
// //               'Images', // 👈 حرف I كبير مطابق للـ Swagger
// //               await MultipartFile.fromFile(
// //                 file.path, 
// //                 filename: file.path.split('/').last,
// //               ),
// //             ),
// //           );
// //         }
// //       }

// //       // طباعة الرابط مع الـ Parameters المدمجة للتأكد بنسبة 100% قبل الإرسال
// //       final Uri finalUri = Uri.parse("${_dio.options.baseUrl}${EndPoints.getapartment}").replace(
// //         queryParameters: queryParams.map((key, value) => MapEntry(key, value.toString())),
// //       );
// //       print("🚀 Requesting Full URL: $finalUri");

// //       // 3. إرسال الطلب النهائي للسيرفر
// //       final response = await _dio.post(
// //         EndPoints.getapartment, 
// //         queryParameters: queryParams, // النصوص في الـ URL
// //         data: formData,               // الصور في الـ Body
// //       );

// //       return response;
// //     } on DioException catch (e) {
// //       throw _handleDioError(e);
// //     } catch (e) {
// //       throw Exception('حدث خطأ غير متوقع: $e');
// //     }
// //   }
// //   /// دالة مساعدة لمعالجة أخطاء الـ Dio وتحويلها لنصوص واضحة
// //   String _handleDioError(DioException error) {
// //     switch (error.type) {
// //       case DioExceptionType.connectionTimeout:
// //         return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
// //       case DioExceptionType.receiveTimeout:
// //         return 'انتهت مهلة استقبال البيانات من السيرفر.';
// //       case DioExceptionType.badResponse:
// //         final statusCode = error.response?.statusCode;
// //         final serverMessage = error.response?.data?['message'] ?? error.response?.statusMessage;
// //         return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب"}';
// //       case DioExceptionType.connectionError:
// //         return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
// //       default:
// //         return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
// //     }
// //   }
// // }




// // // import 'dart:io';
// // // import 'package:dio/dio.dart';
// // // import 'package:moghtarib/core/network/end_points.dart';
// // // import '../model/add_apartment_model.dart';

// // // class ApartmentRepo {
// // //   final Dio _dio;

// // //   ApartmentRepo({Dio? dio}) : _dio = dio ?? Dio(
// // //     BaseOptions(
// // //       baseUrl: EndPoints.baseUrl, 
// // //       connectTimeout: const Duration(seconds: 10),
// // //       receiveTimeout: const Duration(seconds: 10),
// // //     ),
// // //   );

// // //   /// ✅ دالة إضافة شقة جديدة (طلب POST على نفس الـ Endpoint الموحدة)
// // //   Future<Response> addApartment({
// // //     required AddApartmentModel apartment,
// // //     File? baseImage,
// // //     List<File>? additionalImages,
// // //   }) async {
// // //     try {
// // //       // 1. تحويل البيانات العادية لـ Map
// // //       final Map<String, dynamic> apartmentData = apartment.toQueryParameters();

// // //       // 2. استخدام FormData لرفع الصور والنصوص معاً في الـ Body
// // //       final FormData formData = FormData.fromMap(apartmentData);

// // //       // إضافة الصورة الأساسية
// // //       if (baseImage != null) {
// // //         formData.files.add(
// // //           MapEntry(
// // //             'base_image', // الـ Key المتوقع من الـ Backend للصورة الأساسية
// // //             await MultipartFile.fromFile(baseImage.path, filename: baseImage.path.split('/').last),
// // //           ),
// // //         );
// // //       }

// // //       // إضافة الصور الإضافية المتعددة
// // //       if (additionalImages != null && additionalImages.isNotEmpty) {
// // //         for (var file in additionalImages) {
// // //           formData.files.add(
// // //             MapEntry(
// // //               'images', // الـ Key المتوقع من الـ Backend لقائمة الصور الإضافية
// // //               await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
// // //             ),
// // //           );
// // //         }
// // //       }
// // //     print("Full Target URL: ${_dio.options.baseUrl}${EndPoints.getapartment}");
// // //       // 3. إرسال الطلب للسيرفر عبر طلب POST
// // //       final response = await _dio.post(
// // //         EndPoints.getapartment, // 👈 تم التوجيه للـ Endpoint الموحدة لضمان عدم حدوث 404
// // //         data: formData,
// // //       );

// // //       return response;
// // //     } on DioException catch (e) {
// // //       throw _handleDioError(e);
// // //     } catch (e) {
// // //       throw Exception('حدث خطأ غير متوقع: $e');
// // //     }
// // //   }

// // //   /// ✅ دالة جلب الشقق (طلب GET على نفس الـ Endpoint الموحدة)
// // //   Future<List<AddApartmentModel>> getApartments() async {
// // //     try {
// // //       // 👈 تم التعديل هنا لكي تستخدم نفس الـ Endpoint بدلاً من الرابط المكتوب يدوياً
// // //       final response = await _dio.get(EndPoints.getapartment); 
      
// // //       if (response.statusCode == 200) {
// // //         final List<dynamic> data = response.data;
// // //         return data.map((json) => AddApartmentModel.fromJson(json)).toList();
// // //       } else {
// // //         throw Exception('فشل جلب البيانات من السيرفر');
// // //       }
// // //     } on DioException catch (e) {
// // //       throw _handleDioError(e);
// // //     } catch (e) {
// // //       throw Exception('حدث خطأ غير متوقع: $e');
// // //     }
// // //   }

// // //   /// دالة مساعدة لمعالجة أخطاء الـ Dio وتحويلها لنصوص واضحة
// // //   String _handleDioError(DioException error) {
// // //     switch (error.type) {
// // //       case DioExceptionType.connectionTimeout:
// // //         return 'انتهت مهلة الاتصال بالسيرفر، يرجى المحاولة لاحقاً.';
// // //       case DioExceptionType.receiveTimeout:
// // //         return 'انتهت مهلة استقبال البيانات من السيرفر.';
// // //       case DioExceptionType.badResponse:
// // //         final statusCode = error.response?.statusCode;
// // //         final serverMessage = error.response?.data?['message'] ?? error.response?.statusMessage;
// // //         return 'خطأ من السيرفر ($statusCode): ${serverMessage ?? "فشل الطلب"}';
// // //       case DioExceptionType.connectionError:
// // //         return 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة.';
// // //       default:
// // //         return 'عذراً، حدث خطأ أثناء الاتصال بالشبكة.';
// // //     }
// // //   }
// // // }