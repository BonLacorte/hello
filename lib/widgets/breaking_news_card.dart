import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';

class BreakingNewsCard extends StatefulWidget {
  final NewsData data;
  const BreakingNewsCard({required this.data, super.key});

  @override
  State<BreakingNewsCard> createState() => _BreakingNewsCardState();
}

class _BreakingNewsCardState extends State<BreakingNewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
              fit: BoxFit.fill, image: NetworkImage(widget.data.urlToImage!))),
    );
  }
}
