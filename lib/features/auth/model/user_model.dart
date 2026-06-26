// class UserModel {
//   String? id;
//   String? email;
//   String? accessToken;
//   String? department;

//   // التصحيح هنا: أزل الفاصلة بعد this وأضف نقطة قبل department
//   UserModel({this.id, this.email, this.accessToken, this.department});

//   UserModel.fromJson(Map<String, dynamic> userMap) {
//     id = userMap['id']?.toString();
//     email = userMap['email'];
//     accessToken = userMap['token'];
//     department = userMap['department'];
//     department: json['departmentName']?.toString() ?? 'غير محدد',
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'token': accessToken,
//       'department': department,
//     };
//   }
// }

class UserModel {
  String? id;
  String? email;
  String? accessToken;
  String? department;

  UserModel({this.id, this.email, this.accessToken, this.department});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    email = json['email'];
    accessToken = json['token'];
    
    // التصحيح: يتم الإسناد باستخدام علامة اليساوي "=" 
    // وبما أنك تستقبل البيانات في صفحة الأدمن كـ "departmentName"، 
    // فمن الأفضل أن تجعلها مرنة للبحث عن كلا الاسمين:
    department = json['departmentName']?.toString() ?? json['department']?.toString() ?? 'غير محدد';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': accessToken,
      // تأكد هنا من الاسم الذي يتوقعه الـ Backend في عملية التسجيل
      'department': department, 
    };
  }
}