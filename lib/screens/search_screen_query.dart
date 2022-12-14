import 'package:flutter/material.dart';
import 'package:news_app/widgets/category_tabs.dart';
import 'package:news_app/widgets/search_header.dart';

class SearchScreenQuery extends StatefulWidget {
  final String searchQuery;
  const SearchScreenQuery(this.searchQuery, {super.key});

  @override
  State<SearchScreenQuery> createState() => _SearchScreenQueryState();
}

class _SearchScreenQueryState extends State<SearchScreenQuery> {
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
          padding: const EdgeInsets.only(
            left: 15,
            right: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchHeader(),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: CategoryTabs()),
            ],
          ),
        ),
      ),
    );
  }
}
