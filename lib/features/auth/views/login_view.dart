// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/utils/app_colors.dart';
// import '../../../core/widgets/default_text_field.dart';
// import '../../../core/utils/app_assets.dart';

// import '../cubit/login_cubit/login_cubit.dart';
// import '../cubit/login_cubit/login_state.dart';

// import '../../../core/widgets/custom_appbar.dart';
// import '../cubit/login_cubit/login_cubit.dart';
// import '../../../core/widgets/custom_btn.dart';
// import '../../home/home_screens.dart';
// import '../../home/presentation/views/base_home_screen.dart';
// import 'package:moghtarib/features/screen/welcome.dart';


// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LoginCubit(),
//       child: BlocListener<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state is LoginSuccessState) {
//       // 👈 انقل المستخدم من هنا إجبارياً بالـ Navigator العادي بتاع فلاتر لتجربة التنقل
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => BaseHomeScreen(
//             drawerTitle: 'Home',
//             body: Center(
//               child: Text(
//                 'Home',
//                 style: const TextStyle(color: Colors.white, fontSize: 22),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//     if (state is LoginErrorState) {
//       // عشان لو في أيرور مخفي يظهرلك في شاشة الموبايل
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(state.error)),
//       );
//     }
//           // navigation happens inside cubit via callback routing in this implementation
//         },
//         child: BlocBuilder<LoginCubit, LoginState>(
//           builder: (context, state) {
//             final cubit = context.read<LoginCubit>();
//             return Scaffold(
//               backgroundColor: AppColors.scaffoldBackground,
//               body: SafeArea(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Form(
//                     key: cubit.formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Login to your\naccount',
//                           style: TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.w700,
//                             height: 1.3,
//                             color: AppColors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 30),

//                         TextFormField(
//                           controller: cubit.emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: cubit.inputDecoration(
//                             hint: 'Email',
//                             icon: Icons.email,
//                           ),
//                           validator: cubit.validateEmail,
//                         ),
//                         const SizedBox(height: 16),

//                         TextFormField(
//                           controller: cubit.passwordController,
//                           obscureText: cubit.isPasswordHidden,
//                           decoration: cubit.inputDecoration(
//                             hint: 'Password',
//                             icon: Icons.lock,
//                             suffix: IconButton(
//                               icon: Icon(
//                                 cubit.isPasswordHidden
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: cubit.changePasswordVisibility,
//                             ),
//                           ),
//                           validator: cubit.validatePassword,
//                         ),
//                         const SizedBox(height: 24),

//                         SizedBox(
//                           width: 317,
//                           height: 55,
//                           child: state is LoginLoadingState
//                               ? const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Color(0xFFF83758),
//                                   ),
//                                 )
//                               : ElevatedButton(
//                                   onPressed: () => cubit.login(),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.primary,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
                                      
//                                     ),
//                                     elevation: 0,
//                                   ),
//                                   child: const Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                         ),

//                         const SizedBox(height: 18),

//                         Center(
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(
//                                 context,
//                                 '/register',
//                               );
//                             },
//                             child: Text(
//                               "Don’t have an account? Register",
//                               style: TextStyle(
//                                 color: Colors.grey.shade300,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../core/utils/app_colors.dart';
// import '../../../core/widgets/default_text_field.dart';
// import '../../../core/utils/app_assets.dart';

// import '../cubit/login_cubit/login_cubit.dart';
// import '../cubit/login_cubit/login_state.dart';

// import '../../../core/widgets/custom_appbar.dart';
// import '../../../core/widgets/custom_btn.dart';
// import '../../home/home_screens.dart';
// import '../../home/presentation/views/base_home_screen.dart';
// import 'package:moghtarib/features/screen/welcome.dart';
// // TODO: تأكدي من عمل import لملف الـ AppRoutes اللي فيه أسماء الشاشات

// import 'package:moghtarib/core/routes/app_routes.dart';
// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LoginCubit(),
//       child: BlocListener<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state is LoginSuccessState) {
//             // 1. إظهار رسالة النجاح
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Logged In Successfully'), 
//                 backgroundColor: Colors.green,
//               ),
//             );
//            final cubit = LoginCubit.get(context);
//             // 2. قراءة الـ Role القادم من الـ state بعد نجاح تسجيل الدخول وتحويله لـ lowercase
//             // تأكدي أن الـ state شايلة الـ userModel وجواه الـ role
//            final normalizedRole = (cubit.selectedRole ?? '').toLowerCase();

//             String nextRoute;
//             switch (normalizedRole) {
//               case 'admin':
//                 nextRoute = AppRoutes.adminHome; // 👈 هيروح لراوت الأدمن اللي بيعرض الـ users تلقائياً
//                 break;
//               case 'student':
//                 nextRoute = AppRoutes.studentHome;
//                 break;
//               case 'semsar':
//                 nextRoute = AppRoutes.semsarHome;
//                 break;
//               case 'sanaiee':
//                 nextRoute = AppRoutes.sanaieeHome;
//                 break;
//               default:
//                 nextRoute = AppRoutes.welcome;
//             }

//             // 3. التوجيه ومسح الـ Stack تماماً بنفس طريقة الـ Register
//             Navigator.pushNamedAndRemoveUntil(context, nextRoute, (route) => false);
//           }

//           if (state is LoginErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.error), backgroundColor: Colors.red),
//             );
//           }
//         },
//         child: BlocBuilder<LoginCubit, LoginState>(
//           builder: (context, state) {
//             final cubit = context.read<LoginCubit>();
//             return Scaffold(
//               backgroundColor: AppColors.scaffoldBackground,
//               body: SafeArea(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Form(
//                     key: cubit.formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 10),
//                         const Text(
//                           'Login to your\naccount',
//                           style: TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.w700,
//                             height: 1.3,
//                             color: AppColors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 30),

//                         TextFormField(
//                           controller: cubit.emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: cubit.inputDecoration(
//                             hint: 'Email',
//                             icon: Icons.email,
//                           ),
//                           validator: cubit.validateEmail,
//                         ),
//                         const SizedBox(height: 16),

//                         TextFormField(
//                           controller: cubit.passwordController,
//                           obscureText: cubit.isPasswordHidden,
//                           decoration: cubit.inputDecoration(
//                             hint: 'Password',
//                             icon: Icons.lock,
//                             suffix: IconButton(
//                               icon: Icon(
//                                 cubit.isPasswordHidden
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: Colors.grey,
//                               ),
//                               onPressed: cubit.changePasswordVisibility,
//                             ),
//                           ),
//                           validator: cubit.validatePassword,
//                         ),
//                         const SizedBox(height: 24),

//                         SizedBox(
//                           width: 317,
//                           height: 55,
//                           child: state is LoginLoadingState
//                               ? const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Color(0xFFF83758),
//                                   ),
//                                 )
//                               : ElevatedButton(
//                                   onPressed: () => cubit.login(),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: AppColors.primary,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     elevation: 0,
//                                   ),
//                                   child: const Text(
//                                     'Login',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                         ),

//                         const SizedBox(height: 18),

//                         Center(
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(
//                                 context,
//                                 '/register',
//                               );
//                             },
//                             child: Text(
//                               "Don’t have an account? Register",
//                               style: TextStyle(
//                                 color: Colors.grey.shade300,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moghtarib/core/utils/app_colors.dart';
import 'package:moghtarib/core/utils/jwt_role_parser.dart';
import 'package:moghtarib/features/auth/cubit/login_cubit/login_cubit.dart';
import 'package:moghtarib/features/auth/cubit/login_cubit/login_state.dart';
import 'package:moghtarib/features/home/admin/view/admin_home_view.dart';
import '../../home/presentation/views/base_home_screen.dart';
import 'package:moghtarib/features/home/home_screens.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            // 1. هنجيب الـ role اللي راجعة من الـ state بعد نجاح اللوج ان
            // (تأكدي من اسم المتغير جوه الـ LoginSuccessState عندك، لو اسمه userModel.type مثلاً عدليه)
            final token = state.userModel.accessToken;
            final userRole = JwtRoleParser.extractRole(token ?? '');

            // 2. فحص الـ Role وتوجيه المستخدم للصفحة الصح إجبارياً
            if (userRole == 'Admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  // هنا بناديه على صفحة الـ AdminHomeScreen اللي لسه مصلحين الـ import بتاعها
                  builder: (_) => const AdminHomeView(), 
                ),
              );
            } else if (userRole == 'Student') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StudentHome()),
              );
            } else if (userRole == 'Semsar') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SemsarHome()),
              );
            } else {
              // صفحة احتياطية لو الرول مش مطابقة
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BaseHomeScreen(
                    drawerTitle: 'Home',
                    body: const Center(
                      child: Text(
                        'Home',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          
          if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();
            return Scaffold(
              backgroundColor: AppColors.scaffoldBackground,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Login to your\naccount',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 30),

                        TextFormField(
                          controller: cubit.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: cubit.inputDecoration(
                            hint: 'Email',
                            icon: Icons.email,
                          ),
                          validator: cubit.validateEmail,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: cubit.passwordController,
                          obscureText: cubit.isPasswordHidden,
                          decoration: cubit.inputDecoration(
                            hint: 'Password',
                            icon: Icons.lock,
                            suffix: IconButton(
                              icon: Icon(
                                cubit.isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: cubit.changePasswordVisibility,
                            ),
                          ),
                          validator: cubit.validatePassword,
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: 317,
                          height: 55,
                          child: state is LoginLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFF83758),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () => cubit.login(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),

                        const SizedBox(height: 18),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/register',
                              );
                            },
                            child: Text(
                              "Don’t have an account? Register",
                              style: TextStyle(
                                color: Colors.grey.shade300,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}