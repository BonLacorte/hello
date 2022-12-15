import 'package:news_app/models/news.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<NewsData>> getSearchQueryNewsData(
  String query,
  String category,
) async {
  final apiKey = '53d9af9fab3f492da11dfdbb69a1dcac';
  final url =
      'https://newsapi.org/v2/top-headlines?q=$query&category=$category&apiKey=$apiKey';
  final response =
      await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});

  //Map data = jsonDecode(source)
  if (response.statusCode == 200) {
    //print(response.body);
    Map jsonResponse = jsonDecode(response.body);
    List _temp = [];
    String limitedTitle;
    String limitedDate;
    print(query);
    print(category);

    for (var i in jsonResponse['articles']) {
      if (i['author'] != null &&
          i['content'] != null &&
          i['title'] != null &&
          i['url'] != null &&
          i['publishedAt'] != null) {
        limitedDate = i['publishedAt'];
        i['publishedAt'] = '${limitedDate.substring(0, 10)}';

        if (i['urlToImage'] == null) {
          i['urlToImage'] = 'null UrlToImage';
        }
        _temp.add(i);
      }
    }
    return NewsData.newsDataFromSnapshot(_temp);

    //return Product.fromJson(jsonDecode(res.body));
  }
  throw Exception('Failed to load');
}
