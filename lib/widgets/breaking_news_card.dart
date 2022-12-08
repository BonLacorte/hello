import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/details_screen.dart';

class BreakingNewsCard extends StatefulWidget {
  //final NewsData data;
  final String? title;
  final String? author;
  final String? content;
  final String? urlToImage;
  const BreakingNewsCard(this.title, this.author, this.content, this.urlToImage,
      {super.key});

  @override
  State<BreakingNewsCard> createState() => _BreakingNewsCardState();
}

class _BreakingNewsCardState extends State<BreakingNewsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(widget.title, widget.author,
                  widget.content, widget.urlToImage),
            ));
      },
      child: Hero(
        tag: "${widget.title}",
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.urlToImage!),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  widget.author!,
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
