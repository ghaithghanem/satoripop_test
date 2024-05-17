import '../../env.dart';
import '../../model/user_profile.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class UserProfileRepository {
  static const String apiUrl = "$baseUrl2/secure/me";

  static Future<UserProfile> getUserProfile() async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
    );

    try {

      if (json["user"] != null && json["apps"] != null) {
        final User user = User.fromJson(json["user"]);
        final Apps apps = Apps.fromJson(json["apps"]);


        UserProfile userProfile = UserProfile(user: user, apps: apps);


        return userProfile;
      } else {

        print("Error: JSON data is null or missing required properties.");
        throw Exception("JSON data is null or missing required properties.");
      }
    } catch (e) {
      print("Error parsing JSON: $e");
      throw Exception("Error parsing JSON: $e");
    }
  }
}
