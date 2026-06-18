import '../model/user_model.dart';
// class ReportModel {
//   final int? id;
//   final String? text;
//   final String? userId;
//   final UserModel? user; // هنا تكمن قوة الموديل

//   ReportModel({this.id, this.text, this.userId, this.user});

//   factory ReportModel.fromJson(Map<String, dynamic> json) {
//     return ReportModel(
//       id: json['id'],
//       text: json['text'],
//       userId: json['userId'],
//       user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
//     );
//   }
// }

// موديل المستخدم
class User {
  final String? firstName;
  final String? whatsappNumber;

  User({this.firstName, this.whatsappNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      whatsappNumber: json['whatsappNumber'],
    );
  }
}

// موديل التقرير
class ReportModel {
  final int? id;
  final String? text;
  final UserModel? user; 

  ReportModel({this.id, this.text, this.user});

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      text: json['text'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
