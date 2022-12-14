import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/widgets/category_tab.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreenHome extends StatefulWidget {
  final String? title;
  final String? author;
  final String? content;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String category;
  DetailScreenHome(this.title, this.author, this.content, this.url,
      this.urlToImage, this.publishedAt, this.category,
      {super.key});

  @override
  State<DetailScreenHome> createState() => _DetailScreenHomeState();
}

class _DetailScreenHomeState extends State<DetailScreenHome> {
  _launcherUrl() async {
    String? urlLaunch = widget.url;
    if (await canLaunch(urlLaunch!)) {
      await launch(urlLaunch);
    } else {
      throw "Could not launch the url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue.shade500),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.category,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Text(
              //   widget.category,
              //   style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8.0,
              ),

              Text(
                "Published ${widget.publishedAt!}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              Text(
                "by ${widget.author!}",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Hero(
                tag: "${widget.title}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(widget.urlToImage!),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                  '${widget.content!.substring(0, widget.content!.length - 13)}'),
              const SizedBox(
                height: 30,
              ),
              //Text(widget.urlToImage!),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _launcherUrl();
                    },
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.blue[500],
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Click here!",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'More news about ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${widget.category}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue[500]),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
