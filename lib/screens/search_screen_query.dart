import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service_search.dart';
import 'package:news_app/widgets/category_tabs.dart';
import 'package:news_app/widgets/search_header.dart';
import 'package:news_app/widgets/search_query_list_tile.dart';

class SearchScreenQuery extends StatefulWidget {
  final String searchQuery;
  const SearchScreenQuery(this.searchQuery, {super.key});

  @override
  State<SearchScreenQuery> createState() => _SearchScreenQueryState();
}

class _SearchScreenQueryState extends State<SearchScreenQuery> {
  late Future<List<NewsData>> futureSearchQueryNewsData;
  late List<NewsData> _searchQueryNewsData;
  bool _isLoading = true;
  List<String> categories = [
    'Business',
    'Entertainment',
    'Health',
    'Sports',
    'Science',
    'Technology'
  ];
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    futureSearchQueryNewsData =
        getSearchQueryNewsData(widget.searchQuery, selectedCategory);

    getNewsData2();
  }

  Future<void> getNewsData2() async {
    _searchQueryNewsData =
        await getSearchQueryNewsData(widget.searchQuery, selectedCategory);
    setState(() {
      _isLoading = false;
    });
    print(_searchQueryNewsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue[500]),
        title: Row(
          children: [
            //     Text(
            //       "Results for ",
            //       style: TextStyle(
            //           fontSize: 26,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black),
            //     ),
            //     Text(
            //       "\"${widget.searchQuery}\"",
            //       style: TextStyle(
            //           fontSize: 26,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.blue[500]),
            //     ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SearchHeader(),
              // // SingleChildScrollView(
              // //   scrollDirection: Axis.horizontal,
              // //   child: CategoryTabs(),
              // // ),
              // CarouselSlider.builder(
              //   options: CarouselOptions(
              //     height: 40,
              //     viewportFraction: 0.31,
              //     initialPage: 1,
              //     enableInfiniteScroll: false,
              //     pageSnapping: true,
              //   ),
              //   itemCount: categories.length,
              //   itemBuilder: (BuildContext context, int index, id) {
              //     return Container(
              //       margin: EdgeInsets.symmetric(horizontal: 2),
              //       child: ClipRRect(
              //         borderRadius: BorderRadius.circular(30),
              //         child: Container(
              //           padding: EdgeInsets.symmetric(horizontal: 10),
              //           color: Colors.blue[500],
              //           child: InkWell(
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   categories[index],
              //                   style: TextStyle(
              //                       fontSize: 15, color: Colors.white),
              //                 ),
              //               ],
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 selectedCategory = categories[index];
              //                 print(selectedCategory);
              //               });
              //             },
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Results for ",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "\"${widget.searchQuery}\"",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[500]),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : FutureBuilder<List<NewsData>>(
                      future: futureSearchQueryNewsData,
                      initialData: const [],
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<NewsData> news = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView.builder(
                                itemCount: news.length,
                                controller: ScrollController(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    SearchQueryNewsListTile(
                                  _searchQueryNewsData[index].title,
                                  _searchQueryNewsData[index].author,
                                  _searchQueryNewsData[index].content,
                                  _searchQueryNewsData[index].url,
                                  _searchQueryNewsData[index].urlToImage,
                                  _searchQueryNewsData[index].publishedAt,
                                  selectedCategory,
                                  widget.searchQuery,
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
            ],
          ),
        ),
      ),
    );
  }
}
