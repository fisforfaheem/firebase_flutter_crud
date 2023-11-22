// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_crud/database.dart';
import 'package:firebase_flutter_crud/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReadAndDisplayUserData extends StatefulWidget {
  const ReadAndDisplayUserData({super.key});

  @override
  State<ReadAndDisplayUserData> createState() => _ReadAndDisplayUserDataState();
}

class _ReadAndDisplayUserDataState extends State<ReadAndDisplayUserData> {
  //controller
  final TextEditingController nameController = TextEditingController();
  String? name, lastName, age;
  bool isDataFound = false;
  searchUser(userName) async {
    QuerySnapshot value =
        await DatabaseMethods.getUserDetails(nameController.text);
    print(value);
    if (value.docs.isEmpty) {
      Fluttertoast.showToast(
        msg: 'No User found',
      );
      setState(() {
        isDataFound = false;
      });

      return;
    } else {
      UserDetails userDetails =
          UserDetails.fromMap(value.docs[0].data() as Map<String, dynamic>);
      setState(() {
        isDataFound = true;
        name = userDetails.firstName;
        lastName = userDetails.lastName;
        age = userDetails.age;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase App'),
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data?.docs.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return ListTile(
      //             title: Text(snapshot.data?.docs[index]['First Name']),
      //             subtitle: Text(snapshot.data?.docs[index]['Last Name']),
      //             trailing: Text(snapshot.data?.docs[index]['Age']),
      //           );
      //         },
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      body: Column(
        children: [
          const Center(
              child: Text(
            'Write User Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                searchUser(nameController.text);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                minimumSize: const Size(88, 36),
              ),
              child: const Text('Submit'),
            ),
          ),

          //UI to display the data,
          const SizedBox(
            height: 20,
          ),
          isDataFound == false
              ? const Text('No data found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              : Column(
                  children: [
                    Text(
                      'First Name: $name',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Last Name: $lastName',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Age: $age',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
