import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/app_colors.dart';


class WelcomeScreen extends StatelessWidget {

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(
        children: [
          
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height:514.h,
              child: Image.asset(
                'assets/images/Container.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                height: 350.h,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32).r,
                    topRight: Radius.circular(32).r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 37.h, horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mo8tareb — Your Home Away From Home',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25.sp,
                          height: 1.3,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 16.h),
                  
                      Text(
                        'Your journey to the perfect student home starts here. Explore verified listings near your university..',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          height: 1.5,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      const Spacer(), 
                    
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: AppColors.primary, 
                      //     foregroundColor: Colors.white,      
                      //     elevation: 0,                      
                      //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14), 
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10), 
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     Navigator.pushReplacementNamed(context, '/login');
                      //   },
                      //   child: const Text(
                      //     "Let's Start",
                      //     style: TextStyle(
                      //       color: Colors.white, 
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600,
                      //     ),
                      //   ),
                      // ),


                      ElevatedButton(
                         onPressed: () {
                   Navigator.pushReplacementNamed(context, '/login');
                         },
                          style: ElevatedButton.styleFrom(
   
                     backgroundColor: Colors.transparent, 
    
                  elevation: 0,
   
                padding: EdgeInsets.zero,
                 shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
              ),
                   ),
               child: Ink(
            
           decoration: BoxDecoration(
           gradient: const LinearGradient(
        colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
        ),
       child: Container(
   
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      alignment: Alignment.center,
      child: const Text(
        'Let\'s Start',
        style: TextStyle(color: Colors.white),
         ),
         ),
         ),
        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
