class ApiManager {
  ApiManager._();

  //Base URL
  static const baseUrl = 'https://nodeserver.mydevfactory.com:6006';

  //Donation URL
  static const donationBaseUrl = 'www.kilianjornetfoundation.org';
  static const donationHeaders = '/take-action/donate/';

  //
  static const perCapita ='https://ourworldindata.org/per-capita-co2 ';

  //Refresh Token URL
  static const refreshToken = '/api/auth/refresh-tokens';

  //Authentication URL
  static const signUp = '/api/auth/register';
  static const signIn = '/api/auth/login';
  static const sendEmail = '/api/auth/send-verification-email';
  static const verifyEmail = '/api/auth/verify-email';

  //Main URL
  static const createHome = '/api/users/create-user-home-category';
  static const createMobility = '/api/users/create-user-mobility-category';
  static const createGear = '/api/users/create-user-gear-category';
  static const createFood = '/api/users/create-user-food-category';
}
