class ApiManager {
  ApiManager._();

  //Base URL
  static const baseUrl = 'https://nodeserver.mydevfactory.com:6006';

  //Donation URL
  static const donationBaseUrl = 'www.kilianjornetfoundation.org';
  static const donationHeaders = '/take-action/donate/';

  //Hotel URL
  static const hotelUrl = 'www.hotelfootprints.org';

  //
  static const perCapita = 'https://ourworldindata.org/per-capita-co2 ';

  //Refresh Token URL
  static const refreshToken = '/api/auth/refresh-tokens';

  //Device Token URL
  static const addDeviceToken = '/api/auth/add-device-token';
  static const removeDeviceToken = '/api/auth/remove-device-token';

  //Authentication URL
  static const signUp = '/api/auth/register';
  static const signIn = '/api/auth/login';
  static const sendVerificationEmail = '/api/auth/send-verification-email';
  static const verifyEmail = '/api/auth/verify-email';
  static const sendForgotEmail = '/api/auth/forgot-password';
  static const verifyForgotEmail = '/api/auth/verify-forgot-password';
  static const resetPassword = '/api/auth/reset-password';

  //Home URL
  static const getUserTotalCalculation =
      '/api/users/app/get-all-calculation-by-user-id';

  //Calculator URL
  static const createHome = '/api/users/create-user-home-category';
  static const createMobility = '/api/users/create-user-mobility-category';
  static const createGear = '/api/users/create-user-gear-category';
  static const createFood = '/api/users/create-user-other-category';

  //Home URL
  static const getUserFootprint =
      '/api/users/app/get-all-calculation-four-year-by-user-id';

  //Profile URL
  static const getProfile = '/api/users/app/get-profile';
  static const updateProfile = '/api/auth/update-profile';

  //Miscellaneous URL
  static const termsCondition = '/api/cms/app/terms';
  static const privacyPolicy = '/api/cms/app/privacy-policy';
  static const tips = '/api/tips/app/list';
  static const offset = '/api/offset/app/list';
  static const notification = '/api/fcm/app/get-all-notification';
}
