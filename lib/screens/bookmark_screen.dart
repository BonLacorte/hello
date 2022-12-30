import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dart/core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/screens/loading_page.dart';
import 'package:news_app/widgets/bookmarked_news_list_tile.dart';
import 'package:news_app/widgets/search_category_card.dart';
import 'package:news_app/widgets/search_header.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Map<String, dynamic>> _bookmarkedNews = [];
  final uid = firebaseAuth.currentUser!.uid;
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _fetchBookmarkedNews();
    loadScreen();
  }

  Future<void> loadScreen() async {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isFetching = false;
      });
    });
    // setState(() {
    //   _isFetching = false;
    // });
  }

  void _fetchBookmarkedNews() async {
    var snapshot = await firestore
        .collection('bookmarked news')
        .where('uid', isEqualTo: uid)
        .get();
    setState(() {
      _bookmarkedNews = snapshot.docs.map((doc) => doc.data()).toList();
    });
    print("hello $_bookmarkedNews");
  }

  @override
  Widget build(BuildContext context) {
    return _isFetching
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Text(
                    "Bookmarks",
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: ScrollController(),
                          itemCount: _bookmarkedNews.length,
                          itemBuilder: (context, index) {
                            return
                                // Card(
                                //     child: ListTile(
                                //   title: Text(_bookmarkedNews[index]['title']),
                                //   // Other list tile content here...
                                // ));
                                BookmarkedListTile(
                              _bookmarkedNews[index]['title'],
                              _bookmarkedNews[index]['author'],
                              _bookmarkedNews[index]['content'],
                              _bookmarkedNews[index]['url'],
                              _bookmarkedNews[index]['urlToImage'],
                              _bookmarkedNews[index]['publishedAt'],
                              _bookmarkedNews[index]['category'],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  //throw Exception('')
                ],
              ),
            )),
          );
  }
}
