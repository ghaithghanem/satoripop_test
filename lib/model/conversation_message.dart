class InboxResponse {
  final List<Message> messages;
  final List<Tag> tags;
  final int total;

  InboxResponse({
    required this.messages,
    required this.tags,
    required this.total,
  });

  factory InboxResponse.fromJson(Map<String, dynamic> json) {
    // Parse messages list
    List<Message> messages = [];
    if (json['messages'] != null) {
      messages = List<Message>.from(json['messages'].map((message) => Message.fromJson(message)));
    }

    // Parse tags list
    List<Tag> tags = [];
    if (json['tags'] != null) {
      tags = List<Tag>.from(json['tags'].map((tag) => Tag.fromJson(tag)));
    }

    // Parse total
    int total = json['total'] as int;

    return InboxResponse(
      messages: messages,
      tags: tags,
      total: total,
    );
  }


}

class Message {
  final int id;
  final String uid;
  final MessageContent content;
  final Client client;
  final int channel;
  final Sender sender;
  final String timestamp;
  final String status;

  Message({
    required this.id,
    required this.uid,
    required this.content,
    required this.client,
    required this.channel,
    required this.sender,
    required this.timestamp,
    required this.status,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ,
      uid: json['uid']??'' ,
      content: MessageContent.fromJson(json['content']),
      client: Client.fromJson(json['client']),
      channel: json['channel'] ,
      sender: Sender.fromJson(json['sender']),
      timestamp: json['timestamp'] ,
      status: json['status'] ,
    );
  }
}

class MessageContent {
  final int type;
  final String text;
  final List<Item> items;
  final List<Action> actions;

  MessageContent({
    required this.type,
    required this.text,
    required this.items,
    required this.actions,
  });

  factory MessageContent.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MessageContent(
        type: 0,
        text: '',
        items: [], // Empty list since we are not sure about the structure
        actions: [],
      );
    }

    return MessageContent(
      type: json['type'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      items: [], // Empty list since we are not sure about the structure
      actions: json['actions'] != null
          ? List<Action>.from(json['actions'].map((action) => Action.fromJson(action)))
          : [],
    );
  }
}

class Item {
  // You can leave this class empty if you don't have a clear structure for items.
  // Alternatively, you can define properties if you have some known attributes.
}

class Action {
  final int id;
  final int? messageId;
  final int? messageItemId;
  final int type;
  final String text;
  final String? uri;
  final String? metadata;
  final String? format;
  final String? payload;
  final String? iconUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;

  Action({
    required this.id,
    required this.messageId,
    required this.messageItemId,
    required this.type,
    required this.text,
    required this.uri,
    required this.metadata,
    required this.format,
    required this.payload,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Action.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Action(
      id: 0,
      messageId: null,
      messageItemId: null,
      type: 0,
      text: '',
      uri: null,
      metadata: null,
      format: null,
      payload: null,
      iconUrl: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: DateTime.now(),
    ); // Return a default Action instance if json is null

    return Action(
      id: json['id'] ?? 0,
      messageId: json['msg_message_id'] as int?,
      messageItemId: json['message_item_id'] as int?,
      type: json['type'] as int,
      text: json['text'] ?? '',
      uri: json['uri'] ?? '',
      metadata: json['metadata'] ?? '',
      format: json['format'] ?? '',
      payload: json['payload'] ?? '',
      iconUrl: json['icon_url'] ?? '',
      createdAt: json['created_at'] == null ? DateTime.now() : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null ? DateTime.now() : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null ? DateTime.now() : DateTime.parse(json['deleted_at'] as String),
    );
  }

}

class Client {
  final int id;
  final String name;
  final String? picture;

  Client({
    required this.id,
    required this.name,
    required this.picture,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'] ,
      picture: json['picture'] ,
    );
  }
}

class Sender {
  final String type;
  final int? id;
  final String name;
  final String picture;

  Sender({
    required this.type,
    required this.id,
    required this.name,
    required this.picture,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      type: json['type'] ,
      id: json['id'] ,
      name: json['name'] ,
      picture: json['picture'] ,
    );
  }
}

class Tag {
  final int id;
  final String tagName;
  final String color;

  Tag({
    required this.id,
    required this.tagName,
    required this.color,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ,
      tagName: json['tagName'] ,
      color: json['color'] ,
    );
  }
}
