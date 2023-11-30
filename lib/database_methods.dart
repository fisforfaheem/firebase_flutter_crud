import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  static Future addUserDetails(Map<String, dynamic> userInfoMap) async {
    //this will create a new document with a random id and add the data to it
    var docRef = FirebaseFirestore.instance.collection('users').doc();
    userInfoMap['id'] = docRef.id; // Add the document ID to the data
    return await docRef.set(userInfoMap);
  }

  //this will search the user and return the snapshot of the user
  static Future<QuerySnapshot> getUserDetails(String name) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('Name', isEqualTo: name)
        .get();
  }

  //this will return all the users
  static Future<QuerySnapshot> fetchAllUsers() async {
    return await FirebaseFirestore.instance.collection('users').get();
  }

  //this will delete the user
  static Future<void> deleteUser(String name) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('Name', isEqualTo: name)
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.delete();
      }
    });
  }

  //update user details
  static Future<void> updateUserDetails(
      String id, Map<String, dynamic> updatedData) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(updatedData);
  }
}
