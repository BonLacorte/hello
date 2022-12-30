import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/constants.dart';

class HomeController extends GetxController {
  final Rx<Map<String, dynamic>> _bookmarkedNews = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get bookmarkedNews => _bookmarkedNews.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await firestore.collection('bookmarked news').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];

    _bookmarkedNews.value = {'name': name, 'profilePhoto': profilePhoto};
    update();
  }
}
