import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/controller/home_controller.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service_country.dart';
import 'package:news_app/service/api_service_recommended.dart';
import 'package:news_app/widgets/country_news_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app/widgets/category_tabs.dart';
import 'package:news_app/widgets/global_news_list_tile.dart';
import 'package:news_app/widgets/search_header.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final String countryCategory = 'Nationwide';
  final String worldwideCategory = 'Worldwide';
  final String uid;
  const HomeScreen({required this.uid, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<NewsData>> futureCountryNewsData;
  late Future<List<NewsData>> futureRecommendedNewsData;
  late List<NewsData> _countryNewsData;
  late List<NewsData> _recommendNewsData;
  bool _isLoading = true;
  int _selectedIndex = 0;
  final docRef = firestore.collection('users').doc('uid');
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.updateUserId(widget.uid);
    futureCountryNewsData = getCountryNewsData();
    futureRecommendedNewsData = getRecommendedNewsData();

    getNewsData1();
    getNewsData2();
  }

  Future<void> getNewsData1() async {
    _countryNewsData = await getCountryNewsData();
    setState(() {
      _isLoading = false;
    });
    print(_countryNewsData);
  }

  Future<void> getNewsData2() async {
    _recommendNewsData = await getRecommendedNewsData();
    setState(() {
      _isLoading = false;
    });
    print(_recommendNewsData);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final docRef = firestore.collection('users').doc('uid');
    // final future = updateDocument(docRef);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: controller.user['profilePhoto'],
                                  // controller.user['profilePhoto']
                                  height: 50,
                                  width: 50,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Welcome Back!",
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14),
                                  ),
                                  Text(
                                    controller.user['name'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        //scrollDirection: Axis.horizontal,
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    'News in the ',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Philippines',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder<List<NewsData>>(
                    future: futureCountryNewsData,
                    initialData: const [],
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<NewsData> news = snapshot.data!;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CarouselSlider.builder(
                              itemCount: news.length, //news.length,
                              itemBuilder: (context, index, id) =>
                                  CountryNewsCard(
                                      _countryNewsData[index].title,
                                      _countryNewsData[index].author,
                                      _countryNewsData[index].content,
                                      _countryNewsData[index].url,
                                      _countryNewsData[index].urlToImage,
                                      _countryNewsData[index].publishedAt,
                                      widget.countryCategory),
                              options: CarouselOptions(
                                height: 325,
                                //aspectRatio: 2 / 2.5,
                                enableInfiniteScroll: false,
                                enlargeCenterPage: false,
                                pageSnapping: true,
                                viewportFraction: 0.60,
                                initialPage: 0,
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
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    "Global ",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "News",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10),
            //   child: const SingleChildScrollView(
            //       scrollDirection: Axis.horizontal, child: CategoryTabs()),
            // ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder<List<NewsData>>(
                      future: futureRecommendedNewsData,
                      initialData: const [],
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<NewsData> news = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                child: ListView.builder(
                                  controller: ScrollController(),
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      GlobalListTile(
                                          _recommendNewsData[index].title,
                                          _recommendNewsData[index].author,
                                          _recommendNewsData[index].content,
                                          _recommendNewsData[index].url,
                                          _recommendNewsData[index].urlToImage,
                                          _recommendNewsData[index].publishedAt,
                                          widget.worldwideCategory),
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
        )),
      ),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.all(12),
      //   decoration: BoxDecoration(
      //       color: Colors.black, borderRadius: BorderRadius.circular(16)),
      //   child: BottomNavigationBar(
      //       elevation: 0.0,
      //       selectedItemColor: Colors.orange[900],
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           label: "Home",
      //           backgroundColor: Colors.transparent,
      //         ),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.search_sharp),
      //             label: "Search",
      //             backgroundColor: Colors.transparent),
      //         BottomNavigationBarItem(
      //             icon: Icon(Icons.bookmark),
      //             label: "Bookmark",
      //             backgroundColor: Colors.transparent),
      //       ]),
      // ),
    );
  }
}
