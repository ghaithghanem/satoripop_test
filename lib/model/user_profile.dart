class UserProfile {
  final User user;
  final Apps apps;

  UserProfile({required this.user, required this.apps});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      user: User.fromJson(json['user']),
      apps: Apps.fromJson(json['apps']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
    );
  }
}

class Apps {
  final CurrentApp current;
  final List<dynamic> others;

  Apps({required this.current, required this.others});

  factory Apps.fromJson(Map<String, dynamic> json) {
    return Apps(
      current: CurrentApp.fromJson(json['current']),
      others: json['others'],
    );
  }
}

class CurrentApp {
  final int id;
  final String name;
  final String photoUrl;
  final List<Operator> operators;

  CurrentApp({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.operators,
  });

  factory CurrentApp.fromJson(Map<String, dynamic> json) {
    var list = json['operators'] as List;
    List<Operator> operatorList =
    list.map((e) => Operator.fromJson(e)).toList();

    return CurrentApp(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      operators: operatorList,
    );
  }
}

class Operator {
  final int id;
  final String name;
  final String photoUrl;

  Operator({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }
}
