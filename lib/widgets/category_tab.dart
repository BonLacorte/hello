import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  final IconData icon;
  //final bool isActive;
  final String text;
  const CategoryTab({required this.icon, required this.text, super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  bool _isActive = false;

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void activate() {
    setState(() {
      _isActive = true;
    });
    print('${widget.text} is active / true');
  }

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: _isActive ? Colors.blue[900] : Colors.blue[500],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: _isActive ? Colors.white : Colors.black,
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                widget.text,
                style: _isActive
                    ? TextStyle(fontSize: 15, color: Colors.white)
                    : TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
