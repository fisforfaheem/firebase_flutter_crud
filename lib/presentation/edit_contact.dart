import 'package:firebase_flutter_crud/database_methods.dart';
import 'package:firebase_flutter_crud/model/user_model.dart';
import 'package:flutter/material.dart';

// Page for editing user contact details
class EditContactPage extends StatefulWidget {
  final User contact;
  const EditContactPage({Key? key, required this.contact}) : super(key: key);

  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  // Controllers for user details text fields
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  @override
  void initState() {
    // Initialize text fields with current user details
    _name.text = widget.contact.name!;
    _phone.text = widget.contact.phone!;
    _email.text = widget.contact.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Contact')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(_name, 'First Name'),
            const SizedBox(height: 20),
            _buildTextField(_phone, 'Phone Number'),
            const SizedBox(height: 20),
            _buildTextField(_email, 'Email'),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // Helper function to build text fields
  TextFormField _buildTextField(
      TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }

  // Helper function to build save button
  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        User updatedUserDetails = User(
          id: widget.contact.id,
          name: _name.text,
          phone: _phone.text,
          email: _email.text,
        );
        await DatabaseMethods.updateUserDetails(
            updatedUserDetails.id!, updatedUserDetails.toMap());
      },
      child: const Text('Save',
          style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
