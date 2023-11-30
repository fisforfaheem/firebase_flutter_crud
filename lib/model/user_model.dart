//user model
//this is model class for user details
class User {
  final String? name, phone, email, id;
//constructor
  User({this.id, required this.name, required this.phone, required this.email});

//initial data
  factory User.initialData() {
    return User(
      id: '',
      name: '',
      phone: '',
      email: '',
    );
  }

  //get data from firebase
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['Name'],
      phone: map['Phone'],
      email: map['Email'],
    );
  }

//upload  to firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Name': name,
      'Phone': phone,
      'Email': email,
    };
  }
}
