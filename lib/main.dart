import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moghtarib/core/cache/cache_helper.dart';
import 'package:moghtarib/core/network/api_helper.dart';
import 'package:moghtarib/features/auth/views/register_view.dart';
import 'package:moghtarib/features/screen/splash.dart';

import 'login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return ScreenUtilInit(
      designSize: const Size(360, 690), // الأبعاد القياسية الافتراضية للتصميم
      minTextAdapt: true,
      splitScreenMode: true, // تفعيل هذا المتغير هو ما يقضي على الشاشة الحمراء تماماً
      builder: (context, child) {
        return MaterialApp(
          title: 'Moghtarib',
          theme: ThemeData(
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
      home: SplashScreen(),
        );
      },
  );
  }
}