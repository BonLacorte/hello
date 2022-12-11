import 'package:news_app/models/news.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<NewsData>> getBreakingNewsData() async {
  final apiKey = 'ba7df744c6e84c2a95744e72c65ffb92';
  final url =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=ba7df744c6e84c2a95744e72c65ffb92';
  final response =
      await http.get(Uri.parse(url), headers: {'X-Api-Key': apiKey});

  //Map data = jsonDecode(source)
  if (response.statusCode == 200) {
    //print(response.body);
    Map jsonResponse = jsonDecode(response.body);
    List _temp = [];
    String limitedData;
    //print(jsonResponse['articles']);

    for (var i in jsonResponse['articles']) {
      if (i['author'] == null) {
        i['author'] = 'null Author';
      }
      if (i['title'] == null) {
        i['title'] = 'null Title';
      } else {
        limitedData = i['title'];
        i['title'] = limitedData.length < 60
            ? limitedData
            : '${limitedData.substring(0, 57)}...';
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
