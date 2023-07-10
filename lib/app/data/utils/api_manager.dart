class ApiManager {
  ApiManager._();

  //Base URL
  static const baseUrl = 'https://nodeserver.mydevfactory.com:6006';

  //Donation URL
  static const donationBaseUrl = 'www.kilianjornetfoundation.org';
  static const donationHeaders = '/take-action/donate/';

  //Refresh Token URL
  static const refreshToken = '/api/auth/refresh-tokens';

  //Authentication URL
  static const signUp = '/api/auth/register';
  static const signIn = '/api/auth/login';
  static const sendVerificationEmail = '/api/auth/send-verification-email';
  static const verifyEmail = '/api/auth/verify-email';
  static const sendForgotEmail = '/api/auth/forgot-password';
  static const verifyForgotEmail = '/api/auth/verify-forgot-password';
  static const resetPassword = '/api/auth/reset-password';

  //Main URL
  static const getProfile = '/api/users/app/get-profile';

  //Calculator URL
  static const createHome = '/api/users/create-user-home-category';
  static const createMobility = '/api/users/create-user-mobility-category';

  //Miscellaneous URL
  static const termsCondition = '/api/cms/app/terms';
  static const privacyPolicy = '/api/cms/app/privacy-policy';
}
