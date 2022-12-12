import 'package:flutter/material.dart';

const defaultUrlToImage =
    'https://www.acbanet.org/wp-content/uploads/2014/04/news-banner.jpg';

const profileImage =
    "https://th.bing.com/th/id/R.cf7d9b1b32dc4f9190709fc574b3cb24?rik=RwmIIoqAI2HX4A&riu=http%3a%2f%2fvignette3.wikia.nocookie.net%2fpokemon%2fimages%2f9%2f9f%2f143Snorlax_OS_anime.png%2frevision%2flatest%3fcb%3d20140924022259&ehk=EjVFrNyXNw%2fATVmoRgMuf%2f047PpHnDlZUHiEC7Egu4c%3d&risl=&pid=ImgRaw&r=0";

const defaultAuthor = Text(
  "",
  style: TextStyle(
    color: Colors.white54,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);
const defaultContent = Text(
  "",
  style: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);
const defaultTitle = Text(
  "",
  //overflow: TextOverflow.ellipsis,
  style: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
);

const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Screen 1',
    style: optionStyle,
  ),
  Text(
    'Screen 2',
    style: optionStyle,
  ),
  Text(
    'Screen 3',
    style: optionStyle,
  ),
];
