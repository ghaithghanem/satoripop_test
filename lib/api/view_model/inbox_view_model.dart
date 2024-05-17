import 'package:flutter/foundation.dart';
import '../../model/conversation.dart';
import '../repository/inbox_repository.dart';
import '../response/api_response.dart';
import '../response/status.dart';
import 'base_view_model.dart';

class InboxViewModel extends BaseViewModel<Inbox> {

  @override
  Future<ApiResponse> getAll({bool withoutLoading = false}) async {
    return await makeApiCall(
      apiCall: () => InboxRepository.getInbox(),
      withoutLoading: withoutLoading,
    );
  }

  Future<ApiResponse> archiveConversation(int conversationId) async {
    try {
      await InboxRepository.archiveConversation([conversationId]);
      // If the conversation is successfully archived, you may want to update the inbox view.
      return ApiResponse.completed(message: 'Conversation archived successfully.');
    } catch (e) {
      // Handle the error if the conversation couldn't be archived.
      return ApiResponse.error(message: 'Failed to archive conversation: $e');
    }
  }

  Future<ApiResponse> deleteConversation(int conversationId) async {
    try {
      await InboxRepository.deleteConversation([conversationId]);
      // If the conversation is successfully archived, you may want to update the inbox view.
      return ApiResponse.completed(message: 'Conversation archived successfully.');
    } catch (e) {
      // Handle the error if the conversation couldn't be archived.
      return ApiResponse.error(message: 'Failed to archive conversation: $e');
    }
  }
}
