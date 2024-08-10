class PostById {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostById({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  PostById.fromJson(Map<String, dynamic> json) {
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
