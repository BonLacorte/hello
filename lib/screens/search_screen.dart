import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/widgets/category_tabs.dart';
import 'package:news_app/widgets/search_category_card.dart';
import 'package:news_app/widgets/search_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "Search",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchHeader(),
            // Padding(
            //   padding: EdgeInsets.only(left: 10),
            //   child: const SingleChildScrollView(
            //       scrollDirection: Axis.horizontal, child: CategoryTabs()),
            // ),
            Text(
              "Explore Categories",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
              itemCount: Category.searchCategoryList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return SearchCategoryCard(Category.searchCategoryList[index]);
              },
            ),
          ],
        ),
      )),
    );
  }
}
