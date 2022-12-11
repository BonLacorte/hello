import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/details_screen.dart';

class NewsListTile extends StatefulWidget {
  final String? title;
  final String? author;
  final String? content;
  final String? urlToImage;
  const NewsListTile(this.title, this.author, this.content, this.urlToImage,
      {super.key});

  @override
  State<NewsListTile> createState() => _NewsListTileState();
}

class _NewsListTileState extends State<NewsListTile> {
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
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(26.0),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: Hero(
                tag: "${widget.title}",
                child: widget.urlToImage == 'null UrlToImage'
                    ? Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: NetworkImage(defaultUrlToImage),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(widget.urlToImage!),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  children: [
                    widget.title == 'null Title'
                        ? defaultTitle
                        : Text(
                            widget.title!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: 8.0,
                    ),
                    widget.content == 'null Content'
                        ? defaultContent
                        : Text(
                            widget.content!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white54),
                          )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
