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
import '../modules/main_modules/calculator_modules/gear/bindings/gear_binding.dart';
import '../modules/main_modules/calculator_modules/gear/views/gear_view.dart';
import '../modules/main_modules/calculator_modules/house/bindings/house_binding.dart';
import '../modules/main_modules/calculator_modules/house/views/house_view.dart';
import '../modules/main_modules/calculator_modules/mobility/bindings/mobility_binding.dart';
import '../modules/main_modules/calculator_modules/mobility/views/mobility_view.dart';
import '../modules/main_modules/calculator_modules/others/bindings/others_binding.dart';
import '../modules/main_modules/calculator_modules/others/views/others_view.dart';
import '../modules/main_modules/home/bindings/home_binding.dart';
import '../modules/main_modules/home/views/home_view.dart';
import '../modules/main_modules/my_footprint/bindings/my_footprint_binding.dart';
import '../modules/main_modules/my_footprint/views/my_footprint_view.dart';
import '../modules/main_modules/navigation_bar/bindings/navigation_bar_binding.dart';
import '../modules/main_modules/navigation_bar/views/navigation_bar_view.dart';
import '../modules/main_modules/profile/bindings/profile_binding.dart';
import '../modules/main_modules/profile/views/profile_view.dart';
import '../modules/misc_modules/custom_dialog/bindings/custom_dialog_binding.dart';
import '../modules/misc_modules/custom_dialog/views/custom_dialog_view.dart';
import '../modules/misc_modules/notification/bindings/notification_binding.dart';
import '../modules/misc_modules/notification/views/notification_view.dart';
import '../modules/misc_modules/offset/bindings/offset_binding.dart';
import '../modules/misc_modules/offset/views/offset_view.dart';
import '../modules/misc_modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/misc_modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/misc_modules/terms_condition/bindings/terms_condition_binding.dart';
import '../modules/misc_modules/terms_condition/views/terms_condition_view.dart';
import '../modules/misc_modules/tips/bindings/tips_binding.dart';
import '../modules/misc_modules/tips/views/tips_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

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
    GetPage(
      name: _Paths.CUSTOM_DIALOG,
      page: () => CustomDialogView(),
      binding: CustomDialogBinding(),
    ),
    GetPage(
      name: _Paths.GEAR,
      page: () => const GearView(),
      binding: GearBinding(),
    ),
    GetPage(
      name: _Paths.OTHERS,
      page: () => const OthersView(),
      binding: OthersBinding(),
    ),
    GetPage(
      name: _Paths.HOUSE,
      page: () => const HouseView(),
      binding: HouseBinding(),
    ),
    GetPage(
      name: _Paths.MOBILITY,
      page: () => const MobilityView(),
      binding: MobilityBinding(),
    ),
    GetPage(
      name: _Paths.TIPS,
      page: () => const TipsView(),
      binding: TipsBinding(),
    ),
    GetPage(
      name: _Paths.OFFSET,
      page: () => const OffsetView(),
      binding: OffsetBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      page: () => const TermsConditionView(),
      binding: TermsConditionBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
  ];
}
