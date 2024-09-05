class LoginModel {
  int userID;
  int companyID;
  String firstName;
  String lastName;
  String email;
  bool isAdmin;

  LoginModel(
      {required this.userID,
      required this.companyID,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.isAdmin});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userID: json['UserID'] ?? 0,
      companyID: json['CompanyID'] ?? 0,
      firstName: json['FirstName'] ?? "",
      lastName: json['LastName'] ?? "",
      email: json['Email'] ?? "",
      isAdmin: json['IsAdmin'] ?? false,
    );
  }
}

class LoginErrorModel {
  int? userId;
  LoginErrorModel({this.userId});
}
