import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/bookmarkedNews.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service_country.dart';
import 'package:news_app/service/api_service_worldwide.dart';
import 'package:news_app/widgets/category_tab.dart';
import 'package:news_app/widgets/country_news_list_tile.dart';
import 'package:news_app/widgets/global_news_list_tile.dart';
import 'package:news_app/widgets/in_app_webview_button.dart';
import 'package:url_launcher/link.dart';
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
  late Future<List<NewsData>> futureCountryNewsData;
  late Future<List<NewsData>> futureWorldwideNewsData;
  late List<NewsData> _countryNewsData;
  late List<NewsData> _worldwideNewsData;
  bool _isWorldwide = false;
  bool _isLoading = true;
  bool _isBookmarked = false;
  String uid = firebaseAuth.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    futureCountryNewsData = getCountryNewsData();
    getNewsDataCountry();

    _checkIfBookmarked();
  }

  Future<void> getNewsDataCountry() async {
    _countryNewsData = await getCountryNewsData();
    setState(() {
      _isLoading = false;
    });
    print("details_screen_country $_countryNewsData");
  }

  Future<void> getNewsDataWorldwide() async {
    _worldwideNewsData = await getWorldwideNewsData();
    setState(() {
      _isLoading = false;
    });
    print("details_screen_Worldwide $_worldwideNewsData");
  }

  _launcherUrl() async {
    String? urlLaunch = widget.url;
    if (await canLaunch(urlLaunch!)) {
      await launch(urlLaunch);
    } else {
      throw "Could not launch the url";
    }
  }

  Future openBrowserURL({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: inApp,
        forceSafariVC: inApp,
        enableJavaScript: true,
      );
    } else {
      print("The news url can't open");
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
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(widget.urlToImage!),
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
                  Text(
                    'To read the full article ',
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     _launcherUrl();
                  //   },
                  //   child: Card(
                  //     elevation: 1,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     color: Colors.blue[500],
                  //     child: Container(
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.all(5.0),
                  //             child: Text(
                  //               "Click here!",
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.white),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Link(
                  //   target: LinkTarget.self,
                  //   uri: Uri.parse(widget.url!),
                  //   builder: (context, followLink) => ElevatedButton(
                  //       onPressed: followLink, child: Text("Click here!")),
                  // ),
                  // ElevatedButton(
                  //   child: Text('Click here'),
                  //   onPressed: () async {
                  //     openBrowserURL(url: widget.url!, inApp: true);
                  //   },
                  // ),
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
                        future: futureCountryNewsData,
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
                                    itemCount: _countryNewsData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GlobalListTile(
                                            _countryNewsData[index].title,
                                            _countryNewsData[index].author,
                                            _countryNewsData[index].content,
                                            _countryNewsData[index].url,
                                            _countryNewsData[index].urlToImage,
                                            _countryNewsData[index].publishedAt,
                                            widget.category),
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
