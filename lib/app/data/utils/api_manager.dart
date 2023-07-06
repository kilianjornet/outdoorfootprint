class ApiManager {
  ApiManager._();

  //Base URL
  static const baseUrl = 'https://nodeserver.mydevfactory.com:6006';

  //Donation URL
  static const donationBaseUrl = 'www.kilianjornetfoundation.org';
  static const donationHeaders = '/take-action/donate/';

  //Authentication
  static const signUp = '/api/auth/register';
  static const signIn = '/api/auth/login';
}
