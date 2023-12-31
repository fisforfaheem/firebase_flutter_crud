// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_crud/database_methods.dart';
import 'package:firebase_flutter_crud/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReadAndDisplayUserData extends StatefulWidget {
  const ReadAndDisplayUserData({super.key});

  @override
  State<ReadAndDisplayUserData> createState() => _ReadAndDisplayUserDataState();
}

class _ReadAndDisplayUserDataState extends State<ReadAndDisplayUserData> {
  final TextEditingController nameController = TextEditingController();
  // String? name, lastName, Email;
  bool isDataFound = false;
  bool isLoading = false;
  User userDetails = User.initialData();

  Future<void> searchUser(String userName) async {
    setState(() => isLoading = true);
    QuerySnapshot value = await DatabaseMethods.getUserDetails(userName);
    print(value);

    if (value.docs.isEmpty) {
      Fluttertoast.showToast(msg: 'No User found');
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        isLoading = false;
        isDataFound = false;
      });
      return;
    }

    userDetails = User.fromMap(value.docs[0].data() as Map<String, dynamic>);
    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      isDataFound = true;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Search User Data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Enter name of the user',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
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
                FocusScope.of(context).unfocus();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                minimumSize: const Size(88, 36),
              ),
              child: const Text('Search'),
            ),
          ),
          const SizedBox(height: 20),
          isLoading
              ? const CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                )
              : isDataFound == false
                  ? const Text(
                      'No data found',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : Column(
                      children: [
                        UserInfoRow(
                            icon: Icons.person,
                            label: 'Name',
                            value: userDetails.name),
                        UserInfoRow(
                            icon: Icons.family_restroom,
                            label: 'Phone',
                            value: userDetails.phone),
                        UserInfoRow(
                            icon: Icons.cake,
                            label: 'Email',
                            value: userDetails.email),
                      ],
                    ),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const UserInfoRow({
    Key? key,
    required this.icon,
    required this.label,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
