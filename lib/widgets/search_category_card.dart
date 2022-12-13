import 'package:flutter/material.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/screens/category_screen.dart';

class SearchCategoryCard extends StatefulWidget {
  SearchCategoryCard(this.data, {super.key});
  Category data;

  @override
  State<SearchCategoryCard> createState() => _SearchCategoryCardState();
}

class _SearchCategoryCardState extends State<SearchCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 150,
      //width: 300,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryScreen(
                  widget.data.title,
                ),
              ));
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.data.urlToImage))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.data.title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
