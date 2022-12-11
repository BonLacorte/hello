import 'package:news_app/models/news.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<NewsData>> getWorldwideNewsData() async {
  final apiKey = 'ba7df744c6e84c2a95744e72c65ffb92';
  final url =
      'https://newsapi.org/v2/everything?q=&apiKey=ba7df744c6e84c2a95744e72c65ffb92';
  final response =
      await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});

  //Map data = jsonDecode(source)
  if (response.statusCode == 200) {
    //print(response.body);
    Map jsonResponse = jsonDecode(response.body);
    List _temp = [];
    //print(jsonResponse['articles']);

    for (var i in jsonResponse['articles']) {
      if (i['author'] == null) {
        i['author'] = 'null Author';
      }
      if (i['title'] == null) {
        i['title'] = 'null Title';
      }
      if (i['content'] == null) {
        i['content'] = 'null Content';
      }
      if (i['urlToImage'] == null) {
        i['urlToImage'] = 'null UrlToImage';
      }
      //print(i['author']);
      //print(i['articles']);
      _temp.add(i);
    }
    return NewsData.newsDataFromSnapshot(_temp);

    //return Product.fromJson(jsonDecode(res.body));
  }
  throw Exception('Failed to load');
}
