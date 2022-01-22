class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? middleInitial;
  String? contactNumber;
  String? birthday;
  String? brgy;
  String? municipality;
  String? province;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.middleInitial,
      this.contactNumber,
      this.birthday,
      this.brgy,
      this.municipality,
      this.province});

  // get the data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleInitial: map['middleInitial'],
      contactNumber: map['contactNumber'],
      birthday: map['birthday'],
      brgy: map['brgy'],
      municipality: map['municipality'],
      province: map['province'],
    );
  }

  //sending the data to the server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'middleInitial': middleInitial,
      'contactNumber': contactNumber,
      'birthday': birthday,
      'brgy': brgy,
      'municipality': municipality,
      'province': province
    };
  }
}
