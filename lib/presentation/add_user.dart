// ignore_for_file: avoid_print

import 'package:firebase_flutter_crud/database_methods.dart';
import 'package:firebase_flutter_crud/model/user_model.dart';
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

  final formKey = GlobalKey<FormState>();
//controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  uploadData() async {
    User userDetails = User(
      name: _firstNameController.text,
      phone: _lastNameController.text,
      email: _ageController.text,
    );
    print(
      userDetails.toMap(),
    );
//uploading data to firebase
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
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 170,
                ),
                const Text(
                  'Enter User Details',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      uploadData();
                    }
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
      ),
    );
  }
}
