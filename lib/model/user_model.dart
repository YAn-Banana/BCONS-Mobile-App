class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? middleInitial;
  String? gender;
  String? image;
  String? contactNumber;
  String? birthday;
  String? street;
  String? brgy;
  String? municipality;
  String? province;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.middleInitial,
      this.gender,
      this.image,
      this.contactNumber,
      this.birthday,
      this.street,
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
      gender: map['gender'],
      image: map['image'],
      contactNumber: map['contactNumber'],
      birthday: map['birthday'],
      street: map['street'],
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
      'gender': gender,
      'image': image,
      'contactNumber': contactNumber,
      'birthday': birthday,
      'street': street,
      'brgy': brgy,
      'municipality': municipality,
      'province': province
    };
  }
}
