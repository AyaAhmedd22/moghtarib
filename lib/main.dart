import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moghtarib/core/cache/cache_helper.dart';
import 'package:moghtarib/features/auth/views/register_view.dart';
import 'package:moghtarib/features/auth/views/login_view.dart';
import 'package:moghtarib/features/screen/splash.dart';
import 'package:moghtarib/features/screen/welcome.dart';
import 'package:moghtarib/features/home/home_screens.dart';
import 'package:moghtarib/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/setting/cubit/mode/mode_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => ThemeCubit(),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
  title: 'Moghtarib',
  debugShowCheckedModeBanner: false,
  
  // 1. ربط المود الحالي بالكيوبيت
  themeMode: themeMode, 

  // 2. إعدادات الثيم الفاتح (لو المستخدم قلبه لايت)
  theme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.light, // 👈 ضروري جداً
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    // أي تعديلات ألوان تانية للـ Light
  ),

  // 3. إعدادات الثيم الغامق الافتراضي (Dark Theme)
  darkTheme: ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark, // 👈 ده اللي بيخلي باقي الشاشات تسمع وتفهم إنه دارك مود
    scaffoldBackgroundColor: const Color(0xFF121212), // خلفية الدارك
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
    ),
    // أي تعديلات ألوان تانية للـ Dark
  ),

  initialRoute: AppRoutes.splash,
  routes: {
    // الـ routes بتاعتك زي ما هي...
  
  //             return MaterialApp(
  //               title: 'Moghtarib',
  //               debugShowCheckedModeBanner: false,
                
  //               // 2. إعدادات الثيم الفاتح والمظلم
  //               themeMode: themeMode, // يتبع حالة الـ Cubit الحالية والتلقائية من الكاش
  //               theme: ThemeData(
  //                 useMaterial3: true,
  //                 brightness: Brightness.light,
  //                 scaffoldBackgroundColor: Colors.white,
  //                 // تقدري تضيفي ألوان الثيم الفاتح هنا
  //               ),
  //               darkTheme: ThemeData(
  //                 useMaterial3: true,
  //                 brightness: Brightness.dark,
  //                 scaffoldBackgroundColor: const Color(0xFF121212), // لون خلفية مريح للعين
  //                 // تقدري تضيفي ألوان الثيم الغامق هنا
  //               ),

  //               initialRoute: AppRoutes.splash,
  //               routes: {
                  AppRoutes.splash: (context) => const SplashScreen(),
                  AppRoutes.welcome: (context) => const WelcomeScreen(),
                  AppRoutes.register: (context) => RegisterView(),
                  AppRoutes.login: (context) => const LoginView(),
                  AppRoutes.adminHome: (context) => const AdminHome(),
                  AppRoutes.studentHome: (context) => const StudentHome(),
                  AppRoutes.semsarHome: (context) => const SemsarHome(),
                  AppRoutes.sanaieeHome: (context) => const SanaieeHome(),
                },
              );
            },
          ),
        );
      },
    );
  }
}

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await CacheHelper.init();
  
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//   return ScreenUtilInit(
//       designSize: const Size(360, 690), // الأبعاد القياسية الافتراضية للتصميم
//       minTextAdapt: true,
//       splitScreenMode: true, // تفعيل هذا المتغير هو ما يقضي على الشاشة الحمراء تماماً
//       builder: (context, child) {
     
//           return MaterialApp(
//           title: 'Moghtarib',
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             useMaterial3: true,
//           ),
//           initialRoute: AppRoutes.splash,
//           routes: {
//             AppRoutes.splash: (context) => const SplashScreen(),
//             AppRoutes.welcome: (context) => const WelcomeScreen(),
//             AppRoutes.register: (context) => RegisterView(),
//             AppRoutes.login: (context) => const LoginView(),
//             AppRoutes.adminHome: (context) => const AdminHome(),
//             AppRoutes.studentHome: (context) => const StudentHome(),
//             AppRoutes.semsarHome: (context) => const SemsarHome(),
//             AppRoutes.sanaieeHome: (context) => const SanaieeHome(),
//           },

//         );
//       },
//   );
//   }
// }