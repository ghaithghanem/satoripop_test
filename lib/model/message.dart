/*class Message {
  Conversation conversation;
  ClientQt clientQt;
  List<MessageItem> messages;
  int totalCount;

  Message({
    required this.conversation,
    required this.clientQt,
    required this.messages,
    required this.totalCount,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      conversation: Conversation.fromJson(json['conversation']),
      clientQt: ClientQt.fromJson(json['clientQt']),
      messages: List<MessageItem>.from(json['messages'].map((message) => MessageItem.fromJson(message))),
      totalCount: json['totalCount'] as int,
      // Convert to int
    );
  }

}

class Conversation {
  int conversationId;
  bool isBotActivated;
  int unreadCount;
  List<Tag> tags;
  CreatedAt createdAt;

  Conversation({
    required this.conversationId,
    required this.isBotActivated,
    required this.unreadCount,
    required this.tags,
    required this.createdAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['conversationId'],
      isBotActivated: json['isbotActivated'],
      unreadCount: json['unreadCount'],
      tags: List<Tag>.from(json['tags'].map((tag) => Tag.fromJson(tag))),
      createdAt: CreatedAt.fromJson(json['created_at']),
    );
  }
}

class Tag {
  int id;
  int teamId;
  String tagName;
  String color;
  bool selected;

  Tag({
    required this.id,
    required this.teamId,
    required this.tagName,
    required this.color,
    required this.selected,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      teamId: json['team_id'],
      tagName: json['tag_name'],
      color: json['color'],
      selected: json['selected'],
    );
  }
}

class CreatedAt {
  String date;
  int timezoneType;
  String timezone;

  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) {
    return CreatedAt(
      date: json['date'],
      timezoneType: json['timezone_type'],
      timezone: json['timezone'],
    );
  }
}

class ClientQt {
  int id;
  String fullName;
  String phoneNumber;
  String email;
  bool deleted;
  int blacklist;
  String countryCode;
  dynamic city;
  dynamic avatar;
  Map<String, dynamic> channelIds;
  Map<String, dynamic> metas;
  Details details;
  List<dynamic> comingBookings;
  List<dynamic> bookingRequest;
  String roomNumber;
  bool optin;

  ClientQt({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.deleted,
    required this.blacklist,
    required this.countryCode,
    required this.city,
    required this.avatar,
    required this.channelIds,
    required this.metas,
    required this.details,
    required this.comingBookings,
    required this.bookingRequest,
    required this.roomNumber,
    required this.optin,
  });

  factory ClientQt.fromJson(Map<String, dynamic> json) {
    return ClientQt(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      deleted: json['deleted'],
      blacklist: json['blacklist'],
      countryCode: json['countryCode'],
      city: json['city'],
      avatar: json['avatar'],
      channelIds: json['channelIds'],
      metas: json['metas'],
      details: Details.fromJson(json['details']),
      comingBookings: json['comingBookings'],
      bookingRequest: json['bookingRequest'],
      roomNumber: json['room_number'],
      optin: json['optin'],
    );
  }
}

class Details {
  int id;
  dynamic contactIp;
  String lastVisitedPage;
  dynamic currentPages;
  dynamic userAgent;
  dynamic browserLanguage;
  int contactId;

  Details({
    required this.id,
    required this.contactIp,
    required this.lastVisitedPage,
    required this.currentPages,
    required this.userAgent,
    required this.browserLanguage,
    required this.contactId,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json['id'],
      contactIp: json['contact_ip'],
      lastVisitedPage: json['last_visited_page'],
      currentPages: json['current_pages'],
      userAgent: json['user_agent'],
      browserLanguage: json['browser_language'],
      contactId: json['contact_id'],
    );
  }
}

class MessageItem {
  AppUser appUser;
  dynamic groupRef;
  MessageContent message;
  int trigger;
  String uid;

  MessageItem({
    required this.appUser,
    required this.groupRef,
    required this.message,
    required this.trigger,
    required this.uid,
  });

  factory MessageItem.fromJson(Map<String, dynamic> json) {
    return MessageItem(
      appUser: AppUser.fromJson(json['appUser']),
      groupRef: json['groupRef'],
      message: MessageContent.fromJson(json['message']),
      trigger: json['trigger'],
      uid: json['uid'],
    );
  }
}

class AppUser {
  dynamic id;
  dynamic username;
  dynamic photoUrl;

  AppUser({
    required this.id,
    required this.username,
    required this.photoUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      username: json['username'],
      photoUrl: json['photoUrl'],
    );
  }
}

class MessageContent {
  int id;
  String content;
  int imId;
  String imSource;
  String date;
  int type;
  String status;
  List<Action> actions;
  String? messageImId;
  String? mediaUrl;
  String? uri;
  List<Item> items;
  String? title;
  String? subtitle;

  MessageContent({
    required this.id,
    required this.content,
    required this.imId,
    required this.imSource,
    required this.date,
    required this.type,
    required this.status,
    required this.actions,
    this.messageImId,
    this.mediaUrl,
    this.uri,
    required this.items,
    this.title,
    this.subtitle,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      id: json['id'],
      content: json['content'],
      imId: json['imId'],
      imSource: json['imSource'],
      date: json['date'],
      type: json['type'],
      status: json['status'],
      actions: List<Action>.from(json['actions'].map((action) => Action.fromJson(action))),
      messageImId: json['messageImId'],
      mediaUrl: json['mediaUrl'],
      uri: json['uri'],
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}

class Action {
  int id;
  int msgMessageId;
  dynamic messageItemId;
  int type;
  dynamic text;
  dynamic uri;
  String metadata;
  dynamic format;
  dynamic payload;
  dynamic iconUrl;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Action({
    required this.id,
    required this.msgMessageId,
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

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      id: json['id'],
      msgMessageId: json['msg_message_id'],
      messageItemId: json['message_item_id'],
      type: json['type'],
      text: json['text'],
      uri: json['uri'],
      metadata: json['metadata'],
      format: json['format'],
      payload: json['payload'],
      iconUrl: json['icon_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}

class Item {
  int id;
  int msgMessageId;
  String title;
  String description;
  String mediaUrl;
  String mediaType;
  int size;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  dynamic seaDistance;
  dynamic seaUnit;
  dynamic stars;
  bool kidsFriendly;
  bool adultOnly;
  dynamic currency;
  dynamic roomPrice;
  dynamic restaurantKitchen;
  dynamic restaurantCategory;
  dynamic restaurantIncluded;
  dynamic restaurantOpenedClosedDays;
  dynamic googleRate;
  dynamic restaurantOpenAllYear;
  dynamic roomCategory;
  dynamic mesures;
  dynamic occupancyAdult;
  dynamic occupancyChild;
  dynamic options;
  dynamic rooms;
  dynamic beds;
  dynamic shower;
  dynamic kitchen;
  dynamic images;
  dynamic openingHours;
  dynamic surface;
  dynamic racketsAvailable;
  dynamic racketName;
  dynamic privateLesson;
  dynamic racketsAdult;
  dynamic openToPublic;
  dynamic accessFee;
  dynamic courtRates;
  dynamic ageLimit;
  dynamic heated;
  dynamic heatedAllYear;
  dynamic hasSmoking;
  dynamic hasWheelchair;
  dynamic hasWheelchairRampLift;
  dynamic dimensions;
  dynamic poolType;
  dynamic openDate;
  dynamic access;
  dynamic capacity;
  dynamic barCategory;
  dynamic barOpenedDays;
  dynamic barOpenAllYear;
  dynamic freeForGuest;
  dynamic reservationMandatory;
  dynamic pregnacyFriendly;
  dynamic freeFacilities;
  dynamic facilities;
  dynamic boutiqueCategories;
  dynamic boutiqueOpeningDays;
  List<Action> actions;

  Item({
    required this.id,
    required this.msgMessageId,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.mediaType,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.seaDistance,
    required this.seaUnit,
    required this.stars,
    required this.kidsFriendly,
    required this.adultOnly,
    required this.currency,
    required this.roomPrice,
    required this.restaurantKitchen,
    required this.restaurantCategory,
    required this.restaurantIncluded,
    required this.restaurantOpenedClosedDays,
    required this.googleRate,
    required this.restaurantOpenAllYear,
    required this.roomCategory,
    required this.mesures,
    required this.occupancyAdult,
    required this.occupancyChild,
    required this.options,
    required this.rooms,
    required this.beds,
    required this.shower,
    required this.kitchen,
    required this.images,
    required this.openingHours,
    required this.surface,
    required this.racketsAvailable,
    required this.racketName,
    required this.privateLesson,
    required this.racketsAdult,
    required this.openToPublic,
    required this.accessFee,
    required this.courtRates,
    required this.ageLimit,
    required this.heated,
    required this.heatedAllYear,
    required this.hasSmoking,
    required this.hasWheelchair,
    required this.hasWheelchairRampLift,
    required this.dimensions,
    required this.poolType,
    required this.openDate,
    required this.access,
    required this.capacity,
    required this.barCategory,
    required this.barOpenedDays,
    required this.barOpenAllYear,
    required this.freeForGuest,
    required this.reservationMandatory,
    required this.pregnacyFriendly,
    required this.freeFacilities,
    required this.facilities,
    required this.boutiqueCategories,
    required this.boutiqueOpeningDays,
    required this.actions,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      msgMessageId: json['msg_message_id'],
      title: json['title'],
      description: json['description'],
      mediaUrl: json['media_url'],
      mediaType: json['media_type'],
      size: json['size'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      seaDistance: json['sea_distance'],
      seaUnit: json['sea_unit'],
      stars: json['stars'],
      kidsFriendly: json['kids_friendly'],
      adultOnly: json['adult_only'],
      currency: json['currency'],
      roomPrice: json['roomPrice'],
      restaurantKitchen: json['restaurantKitchen'],
      restaurantCategory: json['restaurantCategory'],
      restaurantIncluded: json['restaurantIncluded'],
      restaurantOpenedClosedDays: json['restaurantOpenedClosedDays'],
      googleRate: json['googleRate'],
      restaurantOpenAllYear: json['restaurantOpenAllYear'],
      roomCategory: json['roomCategory'],
      mesures: json['mesures'],
      occupancyAdult: json['occupancyAdult'],
      occupancyChild: json['occupancyChild'],
      options: json['options'],
      rooms: json['rooms'],
      beds: json['beds'],
      shower: json['shower'],
      kitchen: json['kitchen'],
      images: json['images'],
      openingHours: json['openingHours'],
      surface: json['surface'],
      racketsAvailable: json['racketsAvailable'],
      racketName: json['racketName'],
      privateLesson: json['privateLesson'],
      racketsAdult: json['racketsAdult'],
      openToPublic: json['openToPublic'],
      accessFee: json['accessFee'],
      courtRates: json['courtRates'],
      ageLimit: json['ageLimit'],
      heated: json['heated'],
      heatedAllYear: json['heatedAllYear'],
      hasSmoking: json['hasSmoking'],
      hasWheelchair: json['hasWheelchair'],
      hasWheelchairRampLift: json['hasWheelchairRampLift'],
      dimensions: json['dimensions'],
      poolType: json['poolType'],
      openDate: json['openDate'],
      access: json['access'],
      capacity: json['capacity'],
      barCategory: json['barCategory'],
      barOpenedDays: json['barOpenedDays'],
      barOpenAllYear: json['barOpenAllYear'],
      freeForGuest: json['freeForGuest'],
      reservationMandatory: json['reservationMandatory'],
      pregnacyFriendly: json['pregnacyFriendly'],
      freeFacilities: json['freeFacilities'],
      facilities: json['facilities'],
      boutiqueCategories: json['boutiqueCategories'],
      boutiqueOpeningDays: json['boutiqueOpeningDays'],
      actions: List<Action>.from(json['actions'].map((action) => Action.fromJson(action))),
    );
  }
} */
