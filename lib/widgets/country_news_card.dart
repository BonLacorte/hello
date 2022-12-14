import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/details/details_screen_home.dart';

class CountryNewsCard extends StatefulWidget {
  //final NewsData data;
  final String? title;
  final String? author;
  final String? content;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String category;
  const CountryNewsCard(this.title, this.author, this.content, this.url,
      this.urlToImage, this.publishedAt, this.category,
      {super.key});

  @override
  State<CountryNewsCard> createState() => _CountryNewsCardState();
}

class _CountryNewsCardState extends State<CountryNewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreenHome(
                            widget.title,
                            widget.author,
                            widget.content,
                            widget.url,
                            widget.urlToImage,
                            widget.publishedAt,
                            widget.category),
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: widget.urlToImage == 'null UrlToImage'
                      ? Image.network(defaultUrlToImage,
                          width: 300, height: 150, fit: BoxFit.fill)
                      : Image.network(widget.urlToImage!,
                          width: 300, height: 150, fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.title!.length < 57
                        ? Text(
                            '${widget.title!}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            '${widget.title!.substring(0, 57)}...',
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.author == 'null Author'
                            ? defaultAuthor
                            : Text(
                                widget.author!,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
