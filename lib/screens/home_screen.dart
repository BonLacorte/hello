import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/service/api_service_worldwide.dart';
import 'package:news_app/widgets/breaking_news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/widgets/category_tabs.dart';
import 'package:news_app/widgets/news_list_tile.dart';
import 'package:news_app/widgets/search_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewsData>> futureBreakingNewsData;
  late Future<List<NewsData>> futureWorldwideNewsData;
  late List<NewsData> _breakingNewsData;
  late List<NewsData> _worldwideNewsData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    futureBreakingNewsData = getBreakingNewsData();
    futureWorldwideNewsData = getWorldwideNewsData();
    getNewsData1();
    getNewsData2();
  }

  Future<void> getNewsData1() async {
    _breakingNewsData = await getBreakingNewsData();
    setState(() {
      _isLoading = false;
    });
    //print(_breakingNewsData);
  }

  Future<void> getNewsData2() async {
    _worldwideNewsData = await getWorldwideNewsData();
    setState(() {
      _isLoading = false;
    });
    print(_breakingNewsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "NewsApp",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchHeader(),
                Text(
                  'News in Philippines',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder<List<NewsData>>(
                  future: futureBreakingNewsData,
                  initialData: const [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<NewsData> news = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CarouselSlider.builder(
                            itemCount: news.length,
                            itemBuilder: (context, index, id) =>
                                BreakingNewsCard(
                                    _breakingNewsData[index].title,
                                    _breakingNewsData[index].author,
                                    _breakingNewsData[index].content,
                                    _breakingNewsData[index].urlToImage),
                            options: CarouselOptions(
                              height: 300,
                              //aspectRatio: 2 / 2.5,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
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
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: CategoryTabs()),
                ),
                FutureBuilder<List<NewsData>>(
                  future: futureWorldwideNewsData,
                  initialData: const [],
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<NewsData> news = snapshot.data!;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => NewsListTile(
                                _worldwideNewsData[index].title,
                                _worldwideNewsData[index].author,
                                _worldwideNewsData[index].content,
                                _worldwideNewsData[index].urlToImage),
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
                // Column(
                //   children: NewsData.recentNewsData
                //       .map((e) => NewsListTile(e))
                //       .toList(),
                // )
              ],
            )),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(16)),
        child: BottomNavigationBar(
            elevation: 0.0,
            selectedItemColor: Colors.orange[900],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search_sharp),
                  label: "Explore",
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: "Bookmark",
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed_rounded),
                  label: "Feed",
                  backgroundColor: Colors.transparent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                  backgroundColor: Colors.transparent),
            ]),
      ),
    );
  }
}
