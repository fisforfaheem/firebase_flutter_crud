import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  static Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    //this will create a new document with a random id and add the data to it
    return await FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set(userInfoMap);
  }

  //this will search the user and return the snapshot of the user
  static Future<QuerySnapshot> getUserDetails(String name) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('First Name', isEqualTo: name)
        .get();
  }

  //this will return all the users

  static Future<QuerySnapshot> getAllUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }
}
