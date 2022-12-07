import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';

class NewsListTile extends StatefulWidget {
  NewsListTile(this.data, {super.key});
  NewsData data;
  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(12.0),
      height: 130,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(26.0)),
    );
  }
}
