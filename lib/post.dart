class Post {
  int userId;
  int id;
  String title;
  String body;

  Post(this.userId, this.id, this.title, this.body);

  factory Post.fromJson(dynamic json) {
    return Post(
        json['userId'] as int, json['id'] as int, json['title'], json['body']);
  }

  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }
}

// class Feed {
//   List<Post> posts;
//
//   Feed(this.posts);
//
//   factory Feed.fromJson(dynamic json) {
//     return Post(
//         json['userId'] as int, json['id'] as int, json['title'], json['body']);
//   }
// }
