import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkedNews {
  String title;
  String author;
  String content;
  String url;
  String urlToImage;
  String publishedAt;
  String category;
  String id;
  bool isbookmarked;
  String uid;

  BookmarkedNews({
    required this.title,
    required this.author,
    required this.content,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.category,
    required this.id,
    required this.isbookmarked,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "content": content,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "category": category,
        "id": id,
        "isbookmarked": isbookmarked,
        "uid": uid,
      };

  static BookmarkedNews fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return BookmarkedNews(
        title: snapshot['title'],
        author: snapshot['author'],
        content: snapshot['content'],
        url: snapshot['url'],
        urlToImage: snapshot['urlToImage'],
        publishedAt: snapshot['publishedAt'],
        category: snapshot['category'],
        id: snap['id'],
        isbookmarked: snapshot['isbookmarked'],
        uid: snap['uid']);
  }
}
