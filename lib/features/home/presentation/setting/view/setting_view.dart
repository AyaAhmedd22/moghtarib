// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // ⚠️ تأكدي من تعديل مسار الـ ThemeCubit الصحيح عندك هنا
// import '../cubit/mode/mode_cubit.dart';
// class SettingsView extends StatelessWidget {
//   const SettingsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // معرفة إذا كان التطبيق حالياً في الوضع المظلم لتحديد حالة السويتش (Switch)
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Settings',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         // السهم اللي بيرجع لورا بيظهر تلقائياً لو الشاشة مفتوحة عبر Navigation
//         // ولكن للتأكيد وضمان الشكل، قمنا بتخصيصه هنا
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, size: 20),
//           onPressed: () {
//             Navigator.pop(context); // الرجوع للشاشة السابقة
//           },
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Appearance',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 10),
            
//             // بطاقة أنيقة تحتوي على زر تغيير الوضع
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               // يتغير لون البطاقة تلقائياً حسب المود
//               color: isDark ? Colors.grey[900] : Colors.grey[100], 
//               elevation: 0,
//               child: ListTile(
//                 leading: Icon(
//                   isDark ? Icons.dark_mode : Icons.light_mode,
//                   color: isDark ? Colors.amber : Colors.blue,
//                 ),
//                 title: const Text(
//                   'Dark Mode',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 trailing: Switch.adaptive(
//                   value: isDark,
//                   activeColor: Colors.amber, // لون الزرار وهو شغال في الدارك مود
//                   onChanged: (value) {
//                     // استدعاء دالة التغيير من الكيوبيت وحفظها في الكاش فوراً
//                     context.read<ThemeCubit>().toggleTheme();
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }