import '../../model/message.dart';
import '../repository/message_repository.dart';
import '../response/api_response.dart';
import 'base_view_model.dart';

/*class MessageViewModel extends BaseViewModel<Message> {

  @override
  Future<ApiResponse> getAllMessage(int contactId,{bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => MessageRepository.getMessages(contact_id: contactId),
      withoutLoading: withoutLoading,
    );
  }


} */