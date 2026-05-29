import 'package:dartz/dartz.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';
import '../model/all_apartment_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../admin/model/sanaiee_model.dart';
class StudentRepo {
  
  // 1️⃣ جلب جميع الشقق المتاحة للطلاب
  Future<Either<String, List<AllApartmentModel>>> getAllApartments({String? searchText}) async {
    final hasSearch = searchText != null && searchText.trim().isNotEmpty;

    final result = await ApiHelper.get(
      endPoint: hasSearch ? EndPoints.searchapartment : EndPoints.getapartment,
      isProtected: false,
      queryParameters: hasSearch ? {'query': searchText.trim()} : null,
    );

    return result.map((responseBody) {
      // إذا كان الرد عبارة عن List مباشرة
      if (responseBody is List) {
        return responseBody.map((e) => AllApartmentModel.fromJson(Map<String, dynamic>.from(e))).toList();
      }
      
      // إذا كان الرد Map ويحتوي على الكائنات بداخل كباري معينة
      if (responseBody is Map) {
        final dynamic data = responseBody['data'] ?? responseBody['result'] ?? responseBody['apartments'] ?? responseBody;
        
        if (data is List) {
          return data.map((e) => AllApartmentModel.fromJson(Map<String, dynamic>.from(e))).toList();
        }
        
        if (data is Map) {
          final dynamic list = data['data'] ?? data['result'];
          if (list is List) {
            return list.map((e) => AllApartmentModel.fromJson(Map<String, dynamic>.from(e))).toList();
          }
        }
      }
      
      return <AllApartmentModel>[]; 
    });
  }
// class StudentRepo {
  
//   // 1️⃣ جلب جميع الشقق المتاحة للطلاب (مع دعم البحث أو الفلترة بالمدينة مثلاً)
//   Future<Either<String, List<AllApartmentModel>>> getAllApartments({String? searchText}) async {
//     final hasSearch = searchText != null && searchText.trim().isNotEmpty;

//     // استدعاء الـ API الخاص بالشقق
//     final result = await ApiHelper.get(
//       endPoint: hasSearch ? EndPoints.searchapartment : EndPoints.getapartment,
//       isProtected: false,
//       queryParameters: hasSearch ? {'query': searchText.trim()} : null, // أو 'city' حسب السيرفر
//     );

//     return result.map((responseBody) {
//       // إذا كان الرد عبارة عن List مباشرة
//       if (responseBody is List) {
//         return responseBody.map((e) => AllApartmentModel.fromJson(e as Map<String, dynamic>)).toList();
//       }
      
//       // إذا كان الرد Map ويحتوي على الكائنات بداخل كباري معينة (data, result...)
//       if (responseBody is Map<String, dynamic>) {
//         final dynamic data = responseBody['data'] ?? responseBody['result'] ?? responseBody['apartments'] ?? responseBody;
        
//         if (data is List) {
//           return data.map((e) => AllApartmentModel.fromJson(e as Map<String, dynamic>)).toList();
//         }
        
//         if (data is Map<String, dynamic>) {
//           final dynamic list = data['data'] ?? data['result'];
//           if (list is List) {
//             return list.map((e) => AllApartmentModel.fromJson(e as Map<String, dynamic>)).toList();
//           }
//         }
//       }
      
//       return <AllApartmentModel>[]; 
//     });
//   }
// //sanaiee
//  Future<Either<String, List<SanaieeModel>>> getAllSanaieeia({String? searchText}) async {
//     final hasSearch = searchText != null && searchText.trim().isNotEmpty;

//     final result = await ApiHelper.get(
//       endPoint: hasSearch ? EndPoints.searchByName : EndPoints.getAllSanaieeia,
//       isProtected: false,
//       queryParameters: hasSearch ? {'name': searchText.trim()} : null,
//     );

//     return result.map((responseBody) {
//       if (responseBody is List) {
//         return responseBody.map((e) => SanaieeModel.fromJson(e as Map<String, dynamic>)).toList();
//       }
      
//       if (responseBody is Map<String, dynamic>) {
//         final dynamic data = responseBody['data'] ?? responseBody['result'] ?? responseBody['users'] ?? responseBody;
        
//         if (data is List) {
//           return data.map((e) => SanaieeModel.fromJson(e as Map<String, dynamic>)).toList();
//         }
        
//         if (data is Map<String, dynamic>) {
//           final dynamic list = data['data'] ?? data['result'];
//           if (list is List) {
//             return list.map((e) => SanaieeModel.fromJson(e as Map<String, dynamic>)).toList();
//           }
//         }
//       }
      
//       return <SanaieeModel>[]; 
//     });
//   }
  Future<void> openWhatsApp(String phoneNumber) async {
    // كود مخصص لتهيئة الرقم بالشكل الذي يقبله الواتساب الدولي (بدون + أو أصفار إضافية في البداية)
    // إذا كان الرقم مصرياً مثلاً يبدأ بـ 010، يجب أن يصبح 2010
    String formattedPhone = phoneNumber;
    if (phoneNumber.startsWith('0')) {
      formattedPhone = '20${phoneNumber.substring(1)}';
    }

    final Uri whatsappUri = Uri.parse("https://wa.me/$formattedPhone");

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      throw 'حدث خطأ أثناء محاولة فتح واتساب: $e';
    }
  }

  // 2️⃣ دالة حذف المستخدم (تم تقفيلها وحل مشكلة الـ Syntax والـ Return)
  
  
  
}