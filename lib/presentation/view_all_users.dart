import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_crud/database_methods.dart';
import 'package:firebase_flutter_crud/model/user_model.dart';
import 'package:firebase_flutter_crud/presentation/add_user.dart';
import 'package:firebase_flutter_crud/presentation/edit_contact.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewAllUsers extends StatefulWidget {
  const ViewAllUsers({super.key});
  @override
  _ViewAllUsersState createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {
  List<User> userDetailsList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  Future<void> getAllUsers() async {
    setState(() => isLoading = true);
    QuerySnapshot value = await DatabaseMethods.fetchAllUsers();
    if (value.docs.isEmpty) {
      Fluttertoast.showToast(msg: 'No User found');
      await Future.delayed(const Duration(milliseconds: 200));
    } else {
      Fluttertoast.showToast(msg: 'Users found');
      userDetailsList = value.docs
          .map((e) => User.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      await Future.delayed(const Duration(milliseconds: 10));
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('View All Users')),
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator.adaptive()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: userDetailsList.length,
                  itemBuilder: (context, index) {
                    final contactList = userDetailsList[index].toMap();
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Material(
                        elevation: 1,
                        child: Ink(
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: .5,
                              ),
                            ),
                          ),
                          child: ListTile(
                            visualDensity:
                                VisualDensity.adaptivePlatformDensity,
                            dense: false,
                            title: Text(
                              contactList['Name'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      DatabaseMethods.deleteUser(
                                          contactList['Name']);
                                      userDetailsList.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete_rounded,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditContactPage(
                                          contact: userDetailsList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit_rounded,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(contactList['Email']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddUser()));
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
