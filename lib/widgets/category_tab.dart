import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final IconData icon;
  //final bool isActive;
  final String text;
  const CategoryTab(
      {required this.icon,
      //this.isActive = false,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Colors.orange[900],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: Colors.black,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
