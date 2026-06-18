import 'package:dartz/dartz.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/cache/cache_helper.dart';
import '../model/user_model.dart';
import'package:moghtarib/features/home/admin/model/sanaiee_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/report_model.dart';
class AdminRepo {
  
  // 1️⃣ دالة جلب جميع المستخدمين (شغالة وسليمة تماماً)
  Future<Either<String, List<UserModel>>> getAllUsers({String? searchText}) async {
    final hasSearch = searchText != null && searchText.trim().isNotEmpty;

    final result = await ApiHelper.get(
      endPoint: hasSearch ? EndPoints.searchByName : EndPoints.getAllUsers,
      isProtected: false,
      queryParameters: hasSearch ? {'name': searchText.trim()} : null,
    );

    return result.map((responseBody) {
      if (responseBody is List) {
        return responseBody.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
      }
      
      if (responseBody is Map<String, dynamic>) {
        final dynamic data = responseBody['data'] ?? responseBody['result'] ?? responseBody['users'] ?? responseBody;
        
        if (data is List) {
          return data.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        
        if (data is Map<String, dynamic>) {
          final dynamic list = data['data'] ?? data['result'];
          if (list is List) {
            return list.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
          }
        }
      }
      
      return <UserModel>[]; 
    });
  }

  // 2️⃣ دالة حذف المستخدم (تم تقفيلها وحل مشكلة الـ Syntax والـ Return)
  Future<Either<String, bool>> deleteUser({required String userId}) async {
    // رجعناها لـ delete الصحيحة مع الـ Id الكابيتال المتوافق مع الـ Swagger
    final result = await ApiHelper.delete(
      endPoint: '${EndPoints.deleteUser}?Id=$userId',
      isProtected: false,
    );

    return result.map((responseBody) {
      if (responseBody is Map<String, dynamic>) {
        final dynamic successRaw = responseBody['success'] ?? responseBody['Success'];
        if (successRaw is bool) return successRaw;
      }
      return true; // إرجاع افتراضي في حال نجاح الطلب ولم يحتوي الـ Body على كائن معقد
    });
  }
  //sanaiee
 Future<Either<String, List<SanaieeModel>>> getAllSanaieeia({String? searchText}) async {
    final hasSearch = searchText != null && searchText.trim().isNotEmpty;

    final result = await ApiHelper.get(
      endPoint: hasSearch ? EndPoints.searchByName : EndPoints.getAllSanaieeia,
      isProtected: false,
      queryParameters: hasSearch ? {'name': searchText.trim()} : null,
    );

    return result.map((responseBody) {
      if (responseBody is List) {
        return responseBody.map((e) => SanaieeModel.fromJson(e as Map<String, dynamic>)).toList();
      }
      
      if (responseBody is Map<String, dynamic>) {
        final dynamic data = responseBody['data'] ?? responseBody['result'] ?? responseBody['users'] ?? responseBody;
        
        if (data is List) {
          return data.map((e) => SanaieeModel.fromJson(e as Map<String, dynamic>)).toList();
        }
        
        if (data is Map<String, dynamic>) {
          final dynamic list = data['data'] ?? data['result'];
          if (list is List) {
            return list.map((e) => SanaieeModel.fromJson(e as Map<String, dynamic>)).toList();
          }
        }
      }
      
      return <SanaieeModel>[]; 
    });
  }
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
  
// Future<Either<String, List<ReportModel>>> getAllReports() async {
//   // جلب الـ ID بالطريقة الصحيحة للدالة الخاصة بك
//   final String adminId = CacheHelper.getValue('userId')?.toString() ?? "0";

//   final result = await ApiHelper.get(
//     endPoint: EndPoints.getAllReports, 
//     isProtected: true,
//     queryParameters: {
//       'userId': adminId, 
//     },
//   );

//   return result.map((responseBody) {
//     if (responseBody is List) {
//       return responseBody.map((e) => ReportModel.fromJson(e as Map<String, dynamic>)).toList();
//     }
Future<Either<String, List<ReportModel>>> getAllReports() async {
  
  // 1. جلب الـ ID الذي حفظناه أثناء الـ Login
 // في ملف admin_repo.dart
// استبدلي السطر 136 بهذا السطر:
final String adminId = CacheHelper.getValue('userId')?.toString() ?? "";

  // 2. إرسال الطلب مع الـ userId
  final result = await ApiHelper.get(
    endPoint: EndPoints.getAllReports,
    isProtected: true,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    // إرسال الـ userId الذي يطلبه السيرفر
    queryParameters: {
      'userId': adminId ?? "", 
    },
  );

  return result.map((responseBody) {
    // معالجة البيانات كما كانت
    if (responseBody is List) {
      return responseBody.map((e) => ReportModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    
    // في حال كانت البيانات مغلفة داخل مفتاح (مثل "data" أو "result")
    if (responseBody is Map<String, dynamic>) {
       final dynamic data = responseBody['data'] ?? responseBody['result'] ?? responseBody;
       if (data is List) {
         return data.map((e) => ReportModel.fromJson(e as Map<String, dynamic>)).toList();
       }
    }
    
    return <ReportModel>[];
  });
}
}