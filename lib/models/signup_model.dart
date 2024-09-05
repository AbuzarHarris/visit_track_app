import 'dart:convert';

class SignupModel {
  int userId;
  String firstName;
  String lastName;
  String? fatherName;
  String? companyName;
  String? cnic;
  String mobileNo;
  String? dateOfBirth;
  String email;
  String password;
  SignupModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    this.fatherName,
    this.companyName,
    this.cnic,
    required this.mobileNo,
    this.dateOfBirth,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'fatherName': fatherName,
      'companyName': companyName,
      'cnic': cnic,
      'mobileNo': mobileNo,
      'dateOfBirth': dateOfBirth,
      'email': email,
      'password': password,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      userId: map['userId'] as int,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      fatherName:
          map['fatherName'] != null ? map['fatherName'] as String : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      cnic: map['cnic'] != null ? map['cnic'] as String : null,
      mobileNo: map['mobileNo'] as String,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) =>
      SignupModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
