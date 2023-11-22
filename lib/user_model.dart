//user model
//this is model class for user details
class UserDetails {
  final String? firstName, lastName, age;
//constructor
  UserDetails(
      {required this.firstName, required this.lastName, required this.age});

//initial data
  factory UserDetails.initialData() {
    return UserDetails(
      firstName: '',
      lastName: '',
      age: '',
    );
  }

  //get data from firebase
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      firstName: map['First Name'],
      lastName: map['Last Name'],
      age: map['Age'],
    );
  }

//upload  to firebase
  Map<String, dynamic> toMap() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Age': age,
    };
  }
}
