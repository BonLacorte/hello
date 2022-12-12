import 'package:news_app/models/news.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

Future<List<NewsData>> getRecommendedNewsData() async {
  final apiKey = '53d9af9fab3f492da11dfdbb69a1dcac';
  final url;
  final String randomCategory;

  List<String> strings = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];
  final random = Random.secure();
  randomCategory = strings[random.nextInt(strings.length)];
  //randomCategory = 'business';
  url =
      'https://newsapi.org/v2/top-headlines?country=ph&category=$randomCategory&apiKey=53d9af9fab3f492da11dfdbb69a1dcac';
  //'https://newsapi.org/v2/top-headlines?country=us&category=$randomCategory&apiKey=ba7df744c6e84c2a95744e72c65ffb92'
  //print(url);

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
