import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/service/api_service_category.dart';
import 'package:news_app/service/api_service_recommended.dart';
import 'package:news_app/widgets/category_news_list_tile.dart';
import 'package:news_app/widgets/global_news_list_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(this.title, {super.key});
  final String title;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<NewsData>> futureCategoryNewsData;
  late List<NewsData> _categoryNewsData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    futureCategoryNewsData = getCategoryNewsData(widget.title);

    getNewsData2();
  }

  Future<void> getNewsData2() async {
    _categoryNewsData = await getCategoryNewsData(widget.title);
    setState(() {
      _isLoading = false;
    });
    print(_categoryNewsData);
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
            // Text(
            //   title,
            //   style: TextStyle(
            //       fontSize: 26,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
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
                      future: futureCategoryNewsData,
                      initialData: const [],
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<NewsData> news = snapshot.data!;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListView.builder(
                                itemCount: 10,
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    CategoryNewsListTile(
                                  _categoryNewsData[index].title,
                                  _categoryNewsData[index].author,
                                  _categoryNewsData[index].content,
                                  _categoryNewsData[index].urlToImage,
                                  _categoryNewsData[index].publishedAt,
                                  widget.title,
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
    );
  }
}
