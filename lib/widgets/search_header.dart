import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.90,
                  height: 44,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.grey[500]!)),
                  child: TextFormField(
                    onFieldSubmitted: (value) {},
                    style: const TextStyle(fontSize: 16),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 20,
                                  // ),
                                  // Text(
                                  //   "Search for news...",
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ]),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
