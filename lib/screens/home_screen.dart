import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/widgets/breaking_news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/widgets/news_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewsData>> futureBreakingNewsData;
  late Future<List<NewsData>> futureRecentNewsData;
  late List<NewsData> _breakingNewsData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    futureBreakingNewsData = getBreakingNewsData();
    getNewsData();
  }

  Future<void> getNewsData() async {
    _breakingNewsData = await getBreakingNewsData();
    setState(() {
      _isLoading = false;
    });
    //print(_breakingNewsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text(
                  'Breaking News',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
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
                              aspectRatio: 16 / 9,
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
                  height: 40.0,
                ),
                Text(
                  "Recent News",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16.0,
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
