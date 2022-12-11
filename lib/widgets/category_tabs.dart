import 'package:flutter/material.dart';
import 'package:news_app/widgets/category_tab.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          CategoryTab(text: 'Business', icon: Icons.business),
          SizedBox(
            width: 5,
          ),
          CategoryTab(text: 'Entertainment', icon: Icons.theaters),
          SizedBox(
            width: 5,
          ),
          CategoryTab(text: 'General', icon: Icons.star),
          SizedBox(
            width: 5,
          ),
          CategoryTab(text: 'Health', icon: Icons.health_and_safety_outlined),
          SizedBox(
            width: 5,
          ),
          CategoryTab(text: 'Science', icon: Icons.science),
          SizedBox(
            width: 5,
          ),
          CategoryTab(text: 'Sports', icon: Icons.sports),
          SizedBox(
            width: 5,
          ),
          CategoryTab(text: 'Technology', icon: Icons.computer),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
    ;
  }
}
