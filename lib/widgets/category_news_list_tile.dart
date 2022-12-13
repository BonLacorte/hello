import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/details_screen.dart';

class CategoryNewsListTile extends StatefulWidget {
  final String? title;
  final String? author;
  final String? content;
  final String? urlToImage;
  final String? publishedAt;
  final String category;
  const CategoryNewsListTile(this.title, this.author, this.content,
      this.urlToImage, this.publishedAt, this.category,
      {super.key});

  @override
  State<CategoryNewsListTile> createState() => _CategoryNewsListTile();
}

class _CategoryNewsListTile extends State<CategoryNewsListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(widget.title, widget.author,
                  widget.content, widget.urlToImage, widget.category),
            ));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.content!.substring(0, 29)}...',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.publishedAt!,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
