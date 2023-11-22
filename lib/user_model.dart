//user model
//this is model class for user details
class UserDetails {
  final String? firstName, lastName, age;
//constructor
  UserDetails(
      {required this.firstName, required this.lastName, required this.age});
  //this is factory constructor which will return the object of this class
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      firstName: map['First Name'],
      lastName: map['Last Name'],
      age: map['Age'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Age': age,
    };
  }
}
