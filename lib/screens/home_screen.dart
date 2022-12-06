import 'package:flutter/material.dart';
import 'package:news_app/widgets/breaking_news_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                CarouselSlider.builder(itemCount: News)
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
