import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/auth_controller.dart';
import 'package:news_app/screens/bookmark_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/search_screen.dart';

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

List pages = [
  HomeScreen(uid: authController.user.uid),
  SearchScreen(),
  BookmarkScreen(),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
