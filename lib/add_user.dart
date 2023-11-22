// ignore_for_file: avoid_print

import 'package:firebase_flutter_crud/database.dart';
import 'package:firebase_flutter_crud/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
//init
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

//controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  uploadData() async {
    UserDetails userDetails = UserDetails(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      age: _ageController.text,
    );
    print(
      userDetails.toMap(),
    );

    await DatabaseMethods.addUserDetails(userDetails.toMap()).then(
        (value) => Fluttertoast.showToast(msg: 'Data uploaded successfully'));
    //clearing the text fields
    _firstNameController.clear();
    _lastNameController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add User Data'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter User Details',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Age',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  uploadData();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  minimumSize: const Size(88, 36),
                ),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
