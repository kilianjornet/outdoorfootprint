import 'package:shared_preferences/shared_preferences.dart';

class CrudManager {
  CrudManager._();

  static const idKey = 'id';
  static const firstNameKey = 'first_name';
  static const lastNameKey = 'last_name';
  static const emailKey = 'email';
  static const countryKey = 'country';
  static const phoneNumberKey = 'phone_number';
  static const profileImageKey = 'profile_image';

  static Future<void> saveUserData({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String country,
    required String phoneNumber,
    required String profileImage,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(idKey, id);
    await preferences.setString(firstNameKey, firstName);
    await preferences.setString(lastNameKey, lastName);
    await preferences.setString(emailKey, email);
    await preferences.setString(countryKey, country);
    await preferences.setString(phoneNumberKey, phoneNumber);
    await preferences.setString(profileImageKey, profileImage);
  }

  static Future<String?> getId() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(idKey);
  }

  static Future<String?> getFirstName() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(firstNameKey);
  }

  static Future<String?> getLastName() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(lastNameKey);
  }

  static Future<String?> getEmail() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(emailKey);
  }

  static Future<String?> getCountry() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(countryKey);
  }

  static Future<String?> getPhoneNumber() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(phoneNumberKey);
  }

  static Future<String?> getProfileImage() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(profileImageKey);
  }

  static Future<void> clearUserData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(idKey);
    await preferences.remove(firstNameKey);
    await preferences.remove(lastNameKey);
    await preferences.remove(emailKey);
    await preferences.remove(countryKey);
    await preferences.remove(phoneNumberKey);
    await preferences.remove(profileImageKey);
  }
}
