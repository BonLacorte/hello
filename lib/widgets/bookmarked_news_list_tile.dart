import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/details/detail_screen_bookmarked.dart';
import 'package:news_app/screens/details/details_screen_category.dart';

class BookmarkedListTile extends StatefulWidget {
  final String? title;
  final String? author;
  final String? content;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String category;
  const BookmarkedListTile(this.title, this.author, this.content, this.url,
      this.urlToImage, this.publishedAt, this.category,
      {super.key});

  @override
  State<BookmarkedListTile> createState() => _BookmarkedListTileState();
}

class _BookmarkedListTileState extends State<BookmarkedListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreenBookmarked(
                  widget.title,
                  widget.author,
                  widget.content,
                  widget.url,
                  widget.urlToImage,
                  widget.publishedAt,
                  widget.category),
            ));
      },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(12.0),
          height: 135,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 3,
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
              SizedBox(
                width: 10,
              ),
              Flexible(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.title!.length < 52
                            ? Text(
                                '${widget.title!}...',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                '${widget.title!.substring(0, 52)}...',
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
                              '${widget.content!.substring(0, 27)}...',
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
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
