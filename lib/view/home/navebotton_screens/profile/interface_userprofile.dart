import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api/view_model/userprofile_view_model.dart';
import '../../../../model/user_profile.dart';

// Import the User class

abstract class UserProfileAPI {
  static const String userIdKey = "USER_ID";
  static const String userNameKey = "USER_NAME";
  static const String userEmailKey = "USER_EMAIL";
  static const String userPhotoUrlKey = "USER_PHOTO_URL";

  static Future<UserProfile> getUserProfile() async {
    try {
      final response = await UserProfileViewModel().getUserProfile();
      final userProfile = response.data as UserProfile;
      await saveUserProfile(userProfile);

      return userProfile;
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  static Future<void> saveUserProfile(UserProfile userProfile) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final user = userProfile.user;
    await sharedPreferences.setInt(userIdKey, user.id);
    await sharedPreferences.setString(userPhotoUrlKey, user.photoUrl);
    await sharedPreferences.setString(userNameKey, user.name);
    await sharedPreferences.setString(userEmailKey, user.email);
    final storedEmail = sharedPreferences.getString(userEmailKey);
    print('Stored Email: $storedEmail');
    // You can store other attributes here if needed
  }
}
