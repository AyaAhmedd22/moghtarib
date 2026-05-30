import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  
  // التعديل هنا: لو الكاش رجع null أو رجع true، شغل الـ Dark Mode كـ Default
  ThemeCubit() : super(
    CacheHelper.getValue('isDarkMode') == false 
        ? ThemeMode.light 
        : ThemeMode.dark // 👈 كدا الديفولت بقى دارك مود
  );

  // دالة التبديل والحفظ (تظل كما هي)
  void toggleTheme() async {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      await CacheHelper.setValue(key: 'isDarkMode', value: true);
    } else {
      emit(ThemeMode.light);
      await CacheHelper.setValue(key: 'isDarkMode', value: false);
    }
  }
}