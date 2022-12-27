import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_app/constants/constants.dart';

class HomeController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];

    _user.value = {'name': name, 'profilePhoto': profilePhoto};
    update();
  }
}
