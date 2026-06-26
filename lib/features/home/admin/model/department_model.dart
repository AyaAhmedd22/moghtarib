// class DepartmentModel {
//   final int id;
//   final String name;

//   DepartmentModel({this.id = 0, required this.name});

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }
// }
class DepartmentModel {
  final int id;
  final String name;

  DepartmentModel({this.id = 0, required this.name});

  // لتحويل الـ JSON القادم من الـ API إلى كائن
  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}