import 'package:flutter/material.dart';
import 'package:news_app/models/news.dart';

class DetailScreen extends StatefulWidget {
  final String? title;
  final String? author;
  final String? content;
  final String? urlToImage;
  final String category;
  DetailScreen(
      this.title, this.author, this.content, this.urlToImage, this.category,
      {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.blue.shade500),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.category,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.title!,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              widget.author!,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Hero(
              tag: "${widget.title}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(widget.urlToImage!),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(widget.content!),
            const SizedBox(
              height: 30,
            ),
            Text(widget.urlToImage!),
          ],
        ),
      ),
    );
  }
}
