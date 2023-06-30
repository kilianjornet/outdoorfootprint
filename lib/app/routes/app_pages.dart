import 'package:get/get.dart';

import '../modules/auth_modules/forgot_password_modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/auth_modules/forgot_password_modules/reset_password/views/reset_password_view.dart';
import '../modules/auth_modules/forgot_password_modules/send_email/bindings/send_email_binding.dart';
import '../modules/auth_modules/forgot_password_modules/send_email/views/send_email_view.dart';
import '../modules/auth_modules/forgot_password_modules/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/auth_modules/forgot_password_modules/verify_otp/views/verify_otp_view.dart';
import '../modules/auth_modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/auth_modules/sign_in/views/sign_in_view.dart';
import '../modules/auth_modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth_modules/sign_up/views/sign_up_view.dart';
import '../modules/auth_modules/splash/bindings/splash_binding.dart';
import '../modules/auth_modules/splash/views/splash_view.dart';
import '../modules/main_modules/calculator_modules/add/bindings/add_binding.dart';
import '../modules/main_modules/calculator_modules/add/views/add_view.dart';
import '../modules/main_modules/home/bindings/home_binding.dart';
import '../modules/main_modules/home/views/home_view.dart';
import '../modules/main_modules/my_footprint/bindings/my_footprint_binding.dart';
import '../modules/main_modules/my_footprint/views/my_footprint_view.dart';
import '../modules/main_modules/navigation_bar/bindings/navigation_bar_binding.dart';
import '../modules/main_modules/navigation_bar/views/navigation_bar_view.dart';
import '../modules/main_modules/profile/bindings/profile_binding.dart';
import '../modules/main_modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RESET_PASSWORD;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_BAR,
      page: () => const NavigationBarView(),
      binding: NavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.ADD,
      page: () => const AddView(),
      binding: AddBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_FOOTPRINT,
      page: () => const MyFootprintView(),
      binding: MyFootprintBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SEND_EMAIL,
      page: () => const SendEmailView(),
      binding: SendEmailBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
