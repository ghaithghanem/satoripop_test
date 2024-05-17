import '../../env.dart';
import '../../model/conversation.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';
import '../response/api_response.dart'; // Import the conversation model


class InboxRepository {
  static const String apiUrl = "$baseUrl/member/conversations";
  static const String apiUrl2 = "$baseUrl2/secure/archive";
  static const String apiUrl3 = "$baseUrl2/secure/delete";
  static Future<List<Inbox>> getInbox({int page = 0, int limit = 50}) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
      queryParameters: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );

    try {

      if (json["inbox"] != null) {
        final List<dynamic> conversationsJson = json["inbox"]["conversations"];
        List<Conversation> conversations = conversationsJson.map((model) => Conversation.fromJson(model)).toList();


        Inbox inbox = Inbox(
          conversations: conversations,
          total: json["inbox"]["total"],
          unreadCount: json["inbox"]["unreadCount"],
        );

        return [inbox];
      } else {

        print("Error: JSON data is null or missing required properties.");
        return [];
      }
    } catch (e) {
      print("Error parsing JSON: $e");
      return [];
    }
  }
  static Future<void> archiveConversation(List<int> conversationIds) async {
    final Map<String, dynamic> requestBody = {
      "contactIds": conversationIds.map((id) => id.toString()).toList()
    };


    try {
      await ApiService.instance.sendRequest(
        url: apiUrl2,
        httpMethod: HttpMethod.post,
        authIsRequired: true,
        body: requestBody,
      );
      print('Conversation archived successfully.');
    } catch (e) {
      print('Error archiving conversation: $e');
      throw e;
    }
  }
  static Future<void> deleteConversation(List<int> conversationIds) async {
    final Map<String, dynamic> requestBody = {
      "contactIds": conversationIds.map((id) => id.toString()).toList()
    };


    try {
      await ApiService.instance.sendRequest(
        url: apiUrl3,
        httpMethod: HttpMethod.delete,
        authIsRequired: true,
        body: requestBody,
      );
      print('Conversation archived successfully.');
    } catch (e) {
      print('Error archiving conversation: $e');
      throw e;
    }
  }
}