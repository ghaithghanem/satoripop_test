import '../../env.dart';
import '../../model/conversation_message.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

import '../../env.dart';
import '../../model/conversation_message.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';

class ConversationMessageRepository {
  static const String baseUrl = "https://messaging-api.quicktext.im/api/member/conversations";

  static Future<List<InboxResponse>> getConvMessages({required int contact_Id, int page = 0, int limit = 10}) async {
    final String apiUrl = "$baseUrl/$contact_Id/messages";

    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
      queryParameters: {
        'contactId': contact_Id.toString(),
        'pagination': limit.toString(),
        'page': page.toString(),
      },
    );
    try {
      if (json["messages"] != null && json["tags"] != null && json["total"] != null) {
        // Parse messages list
        final List<dynamic>? messagesJson = json["messages"];
        final List<Message> messages = messagesJson?.map((messageJson) => Message.fromJson(messageJson)).toList() ?? [];

        // Parse tags list
        final List<dynamic>? tagsJson = json["tags"];
        final List<Tag> tags = tagsJson?.map((tagJson) => Tag.fromJson(tagJson)).toList() ?? [];

        // Parse total
        final int total = json["total"] as int;

        InboxResponse inbox = InboxResponse(
          messages: messages,
          tags: tags,
          total: total,
        );
        return [inbox];

      } else {
        // Handle missing data
        print("Error: JSON data is null or missing required properties.");
        throw Exception("JSON data is null or missing required properties.");
      }
    } catch (e) {
      print("Error parsing JSON: $e");
      throw Exception("Error parsing JSON: $e");
    }
  }
}

