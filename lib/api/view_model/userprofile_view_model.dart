import '../../model/user_profile.dart';
import '../repository/userprofile_repository.dart';
import '../response/api_response.dart';
import '../response/status.dart';
import 'base_view_model.dart';

class UserProfileViewModel extends BaseViewModel<UserProfile> {

  @override
  Future<ApiResponse> getUserProfile({bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => UserProfileRepository.getUserProfile(),
      withoutLoading: withoutLoading,
    );
  }
}