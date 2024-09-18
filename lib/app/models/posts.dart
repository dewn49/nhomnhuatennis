import 'dart:convert';

class Posts {
  int? userId;
  int? id;
  String? title;
  String? body;

  Posts({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title']?.toString();
    body = json['body']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

////////////////////////////////////////////////////////
class Member {
  int? id;
  String? name;
  String? meta;
  List<int> stats = [
    0,
    0,
    0,
    0,
    0
  ]; //List<int> = [win, tie, los, deuce, point];

  Member({
    this.id,
    this.name,
    this.meta,
  });

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name']?.toString();
    meta = json['meta']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'meta': meta,
    };
  }
}

////////////////////////////////////////////////////////
///
class NNMatch {
  int? id = -1;
  Map<dynamic, dynamic> nhom = <dynamic, dynamic>{
    'player1': 0,
    'player2': 0,
    'point': 0,
    'meta': '{}'
  };
  Map<dynamic, dynamic> nhua = <dynamic, dynamic>{
    'player1': 0,
    'player2': 0,
    'point': 0,
    'meta': '{}'
  };

  NNMatch({
    this.id,
  });

  NNMatch.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    nhom['player1'] = json['nhom1'];
    nhom['player2'] = json['nhom2'];
    nhom['point'] = json['nhom_point'];

    nhua['player1'] = json['nhua1'];
    nhua['player2'] = json['nhua2'];
    nhua['point'] = json['nhua_point'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nhom': nhom.toString(),
      'nhua': nhua.toString(),
    };
  }

  Map<dynamic, dynamic>? getNhom() {
    return this.nhom;
  }

  Map<dynamic, dynamic>? getNhua() {
    return this.nhua;
  }
}
