import '../../env.dart';
import '../../model/message.dart';
import '../network/api_service.dart';
import '../network/http_method.dart';
import '../response/api_response.dart';

/*class MessageRepository {
  static const String apiUrl = "$baseUrl2/secure/messages";

  static Future<Message> getMessages({int contact_id = 0  ,int page = 1, int limit = 50}) async {
    final Map<String, dynamic> json = await ApiService.instance.sendRequest(
      url: apiUrl,
      httpMethod: HttpMethod.get,
      authIsRequired: true,
      queryParameters: {
        'contact_id': contact_id.toString(),
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );

    try {
      if (json["messages"] != null) {
        final List<dynamic> messagesJson = json["messages"];
        List<MessageItem> messages = messagesJson.map((model) => MessageItem.fromJson(model)).toList();

        Message message = Message(
          conversation: Conversation.fromJson(json['conversation']),
          clientQt: ClientQt.fromJson(json['clientQt']),
          messages: messages,
          totalCount: json['totalCount'],
        );

        print("print response message .$message");
        return Message(
          conversation: Conversation.fromJson(json['conversation']),
          clientQt: ClientQt.fromJson(json['clientQt']),
          messages: messages,
          totalCount: json['totalCount'],
        );
      } else {
        print("Error: JSON data is null or missing required properties.");
        return Message(conversation: Conversation(conversationId: 0, isBotActivated: false, unreadCount: 0, tags: [], createdAt: CreatedAt(date: "", timezoneType: 0, timezone: "")), clientQt: ClientQt(id: 0, fullName: "", phoneNumber: "", email: "", deleted: false, blacklist: 0, countryCode: "", city: null, avatar: null, channelIds: {}, metas: {}, details: Details(id: 0, contactIp: null, lastVisitedPage: "", currentPages: null, userAgent: null, browserLanguage: null, contactId: 0), comingBookings: [], bookingRequest: [], roomNumber: "", optin: false), messages: [], totalCount: 0);
      }
    } catch (e) {
      print("Error parsing JSON: $e");
      return Message(conversation: Conversation(conversationId: 0, isBotActivated: false, unreadCount: 0, tags: [], createdAt: CreatedAt(date: "", timezoneType: 0, timezone: "")), clientQt: ClientQt(id: 0, fullName: "", phoneNumber: "", email: "", deleted: false, blacklist: 0, countryCode: "", city: null, avatar: null, channelIds: {}, metas: {}, details: Details(id: 0, contactIp: null, lastVisitedPage: "", currentPages: null, userAgent: null, browserLanguage: null, contactId: 0), comingBookings: [], bookingRequest: [], roomNumber: "", optin: false), messages: [], totalCount: 0);
    }
  }

}*/
