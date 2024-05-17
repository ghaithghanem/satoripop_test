class Inbox {
  List<Conversation> conversations;
  int total;
  int unreadCount;

  Inbox({
    required this.conversations,
    required this.total,
    required this.unreadCount,
  });

  factory Inbox.fromJson(Map<String, dynamic> json) {
    return Inbox(
      conversations: List<Conversation>.from(json['conversations'].map((conversation) => Conversation.fromJson(conversation))),
      total: json['total'],
      unreadCount: json['unreadCount'],
    );
  }
}

class Conversation {
  int id;
  bool isBotActivated;
  int unreadCount;
  int totalMessages;
  List<Tag> tags;
  Team team;
  LastMessage lastMessage;
  Client client;

  Conversation({
    required this.id,
    required this.isBotActivated,
    required this.unreadCount,
    required this.totalMessages,
    required this.tags,
    required this.team,
    required this.lastMessage,
    required this.client,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      isBotActivated: json['isbotActivated'],
      unreadCount: json['unreadCount'],
      totalMessages: json['totalMessages'],
      tags: List<Tag>.from(json['tags'].map((tag) => Tag.fromJson(tag))),
      team: Team.fromJson(json['team']),
      lastMessage: LastMessage.fromJson(json['lastMessage']),
      client: Client.fromJson(json['client']),
    );
  }
}
class Tag {
  int id;
  String tagName;
  String color;

  Tag({
    required this.id,
    required this.tagName,
    required this.color,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      tagName: json['tagName'],
      color: json['color'],
    );
  }
}

class Team {
  int id;
  String name;

  Team({
    required this.id,
    required this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
    );
  }
}

class LastMessage {
  int id;
  String content;
  int type;
  String status;
  String date;
  String sender;
  int channel;

  LastMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.status,
    required this.date,
    required this.sender,
    required this.channel,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['id'],
      content: json['content'],
      type: json['type'],
      status: json['status'],
      date: json['date'],
      sender: json['sender'],
      channel: json['channel'],
    );
  }
}

class Client {
  int id;
  String name;
  String? avatarUrl; // Nullable

  Client({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatar'], // Nullable
    );
  }
}
