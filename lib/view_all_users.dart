// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_crud/database.dart';
import 'package:firebase_flutter_crud/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewAllUsers extends StatefulWidget {
  const ViewAllUsers({super.key});

  @override
  State<ViewAllUsers> createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {
  @override
  void initState() {
    super.initState();
    getAllUsers();
    //get all users with getAllUsers();
  }

  UserDetails userDetails = UserDetails.initialData();
  bool isLoading = false;

  Future<void> getAllUsers() async {
    setState(() => isLoading = true);
    QuerySnapshot value = await DatabaseMethods.getAllUsers();
    print(value);

    //get all users from firebase
    userDetails =
        UserDetails.fromMap(value.docs[0].data() as Map<String, dynamic>);

    if (value.docs.isEmpty) {
      Fluttertoast.showToast(msg: 'No User found');
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        isLoading = false;
        // isDataFound = false;
      });
      return;
    }
    if (value.docs.isNotEmpty) {
      Fluttertoast.showToast(msg: ' User found');
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        isLoading = false;
        // isDataFound = false;
      });
      return;
    }

    // userDetails =
    //     UserDetails.fromMap(value.docs[0].data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('View All Users', style: TextStyle(fontSize: 30)),
            Text('First Name: ${userDetails.firstName}'),
            //listview builder to display all users,
            //use userDetails.firstName, userDetails.lastName, userDetails.age,

            // ListView.builder(
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(userDetails.firstName!),
            //       subtitle: Text(userDetails.lastName!),
            //       trailing: Text(userDetails.age!),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
