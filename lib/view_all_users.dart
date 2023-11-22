// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_crud/add_user.dart';
import 'package:firebase_flutter_crud/database.dart';
import 'package:firebase_flutter_crud/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
  }

  List<UserDetails> userDetailsList = [];
  bool isLoading = false;

  Future<void> getAllUsers() async {
    setState(() => isLoading = true);
    QuerySnapshot value = await DatabaseMethods.fetchAllUsers();
    print(value);

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
      userDetailsList = value.docs
          .map((e) => UserDetails.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      await Future.delayed(const Duration(milliseconds: 10));
      setState(() {
        isLoading = false;
        // isDataFound = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Column(
                children: [
                  const Text('All Contacts', style: TextStyle(fontSize: 30)),
                  ListView.builder(
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
                              // leading: InkWell(
                              //   onTap: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) => Dialog(
                              //         child: Image.network(contactList['image']!),
                              //       ),
                              //     );
                              //   },
                              //   child: CircleAvatar(
                              //     backgroundImage: NetworkImage(contactList['image']!),
                              //   ),
                              // ),
                              title: Text(
                                contactList['Name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.email_rounded,
                                      size: 30,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final url =
                                          'https://wa.me/${contactList['Name']}';
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.phone_rounded,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(contactList['Email']),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EditContactPage(
                                //       contact: ContactList.contact[index],
                                //     ),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        enableFeedback: true,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUser()));
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
