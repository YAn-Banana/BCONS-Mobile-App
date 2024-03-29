class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? middleInitial;
  String? fullName;
  String? gender;
  String? image;
  String? contactNumber;
  String? birthday;
  String? age;
  String? bloodType;
  String? street;
  String? brgy;
  String? municipality;
  String? province;
  String? latitude;
  String? longitude;
  String? address;
  String? liveMunicipality;
  String? visibility;
  String? liveLatitude;
  String? liveLongitude;
  String? status;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.middleInitial,
      this.fullName,
      this.gender,
      this.image,
      this.contactNumber,
      this.birthday,
      this.age,
      this.bloodType,
      this.street,
      this.brgy,
      this.municipality,
      this.province,
      this.latitude,
      this.longitude,
      this.address,
      this.liveMunicipality,
      this.visibility,
      this.liveLatitude,
      this.liveLongitude,
      this.status});

  // get the data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      middleInitial: map['middleInitial'],
      fullName: map['fullName'],
      gender: map['gender'],
      image: map['image'],
      contactNumber: map['contactNumber'],
      birthday: map['birthday'],
      age: map['age'],
      bloodType: map['bloodType'],
      street: map['street'],
      brgy: map['brgy'],
      municipality: map['municipality'],
      province: map['province'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
      liveMunicipality: map['liveMunicipality'],
      visibility: map['visibility'],
      liveLatitude: map['liveLatitude'],
      liveLongitude: map['liveLongitude'],
      status: map['status'],
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
      'fullName': fullName,
      'gender': gender,
      'image': image,
      'contactNumber': contactNumber,
      'birthday': birthday,
      'age': age,
      'bloodType': bloodType,
      'street': street,
      'brgy': brgy,
      'municipality': municipality,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'liveMunicipality': liveMunicipality,
      'visibility': visibility,
      'liveLatitude': liveLatitude,
      'liveLongitude': liveLongitude,
      'status': status,
    };
  }
}
