class ApiManager {
  ApiManager._();

  //Base URL
  static const baseUrl = 'https://nodeserver.mydevfactory.com:6006';

  //Donation URL
  static const donationBaseUrl = 'www.kilianjornetfoundation.org';
  static const donationHeaders = '/take-action/donate/';

  //Refresh Token
  static const refreshToken = '/api/auth/refresh-tokens';

  //Authentication
  static const signUp = '/api/auth/register';
  static const signIn = '/api/auth/login';
  static const sendEmail = '/api/auth/send-verification-email';
  static const verifyEmail = '/api/auth/verify-email';
}
