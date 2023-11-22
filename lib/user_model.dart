//user model
//this is model class for user details
class UserDetails {
  final String? name, phone, email;
//constructor
  UserDetails({required this.name, required this.phone, required this.email});

//initial data
  factory UserDetails.initialData() {
    return UserDetails(
      name: '',
      phone: '',
      email: '',
    );
  }

  //get data from firebase
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['Name'],
      phone: map['Phone'],
      email: map['Email'],
    );
  }

//upload  to firebase
  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Phone': phone,
      'Email': email,
    };
  }
}
