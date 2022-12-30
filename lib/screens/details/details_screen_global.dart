import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/bookmarkedNews.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service_category.dart';
import 'package:news_app/service/api_service_worldwide.dart';
import 'package:news_app/widgets/category_news_list_tile.dart';
import 'package:news_app/widgets/category_tab.dart';
import 'package:news_app/widgets/global_news_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_dart/firebase_dart.dart' as fb;

class DetailScreenGlobal extends StatefulWidget {
  final String? title;
  final String? author;
  final String? content;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String category;
  const DetailScreenGlobal(this.title, this.author, this.content, this.url,
      this.urlToImage, this.publishedAt, this.category,
      {super.key});

  @override
  State<DetailScreenGlobal> createState() => _DetailScreenGlobalState();
}

class _DetailScreenGlobalState extends State<DetailScreenGlobal> {
  late Future<List<NewsData>> futureWorldwideNewsData;
  late List<NewsData> _worldwideNewsData;
  bool _isLoading = true;
  bool _isBookmarked = false;
  String uid = firebaseAuth.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    futureWorldwideNewsData = getWorldwideNewsData();
    getNewsData2();
    _checkIfBookmarked();
  }

  Future<void> getNewsData2() async {
    _worldwideNewsData = await getWorldwideNewsData();
    setState(() {
      _isLoading = false;
    });
  }

  _launcherUrl() async {
    String? urlLaunch = widget.url;
    if (await canLaunch(urlLaunch!)) {
      await launch(urlLaunch);
    } else {
      throw "Could not launch the url";
    }
  }

  void _checkIfBookmarked() async {
    var snapshot = await firestore
        .collection('bookmarked news')
        .where('uid', isEqualTo: uid)
        .get();
    List<Map<String, dynamic>> bookmarkedNews =
        snapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      _isBookmarked =
          bookmarkedNews.any((news) => news['content'] == widget.content!);
    });
    print("_checkIfBookmarked function $_isBookmarked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue.shade500),
        actions: [
          IconButton(
            icon: _isBookmarked
                ? Icon(
                    Icons.bookmark,
                    color: Colors.blue.shade500,
                  )
                : Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.blue.shade500,
                  ),
            onPressed: () async {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              print(_isBookmarked);
              String uid = firebaseAuth.currentUser!.uid;
              var allDocs = await firestore.collection('bookmarked news').get();
              int len = allDocs.docs.length;
              print(len);

              if (_isBookmarked) {
                // Add bookmarked news to Firebase database
                BookmarkedNews bookmarkedNews = BookmarkedNews(
                    title: widget.title!,
                    author: widget.author!,
                    content: widget.content!,
                    url: widget.url!,
                    urlToImage: widget.urlToImage!,
                    publishedAt: widget.publishedAt!,
                    category: widget.category,
                    id: "Bookmarked News $len",
                    isbookmarked: _isBookmarked,
                    uid: uid);

                await firestore
                    .collection("bookmarked news")
                    .doc('Bookmarked News $len')
                    .set(
                      bookmarkedNews.toJson(),
                    );
              } else {
                // Remove bookmarked news from Firebase database
                QuerySnapshot snapshot = await firestore
                    .collection('bookmarked news')
                    .where('title', isEqualTo: widget.title)
                    .where('author', isEqualTo: widget.author)
                    .where('content', isEqualTo: widget.content)
                    .where('url', isEqualTo: widget.url)
                    .where('uid', isEqualTo: uid)
                    .get();

                DocumentReference docUser = snapshot.docs.first.reference;

                docUser
                    .delete()
                    .then((value) => print("bookmark deleted"))
                    .catchError(
                        (error) => print("Failed to delete bookmark: $error"));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
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

              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'To read the full article ',
                  ),
                  ElevatedButton(
                    child: Text('Click here'),
                    onPressed: () async {
                      // Use the 'launch' function to open the link in an in-app webview
                      await launch(
                        widget.url!,
                        forceWebView: true,
                      );
                    },
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
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder<List<NewsData>>(
                        future: futureWorldwideNewsData,
                        initialData: const [],
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<NewsData> news = snapshot.data!;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SingleChildScrollView(
                                  child: ListView.builder(
                                    controller: ScrollController(),
                                    itemCount: _worldwideNewsData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GlobalListTile(
                                      _worldwideNewsData[index].title,
                                      _worldwideNewsData[index].author,
                                      _worldwideNewsData[index].content,
                                      _worldwideNewsData[index].url,
                                      _worldwideNewsData[index].urlToImage,
                                      _worldwideNewsData[index].publishedAt,
                                      widget.category,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
