
import '../../model/conversation_message.dart';
import '../repository/conversation_message_repository.dart';
import '../response/api_response.dart';
import 'base_view_model.dart';

class ConversatioMsgViewModel extends BaseViewModel<Message> {

  @override
  Future<ApiResponse> getAllConvMessage(int contactId,{bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => ConversationMessageRepository.getConvMessages(contact_Id: contactId),
      withoutLoading: withoutLoading,

    );
  }
  // Method to delete a conversation message


}