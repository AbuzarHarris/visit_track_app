import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/signup_api.dart';
import 'package:personal_phone_dictionary/components/date_picker_component.dart';
import 'package:personal_phone_dictionary/components/text_input_component.dart';
import 'package:personal_phone_dictionary/components/toasts.dart';
import 'package:personal_phone_dictionary/components/verify_otp_component.dart';
import 'package:personal_phone_dictionary/models/signup_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/helpers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _fathersName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _cnic = TextEditingController();
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  DateTime? _dateOfBirth;
  bool _isPending = false;

  Future<void> _onSubmit() async {
    try {
      setState(() {
        _isPending = true;
      });
      if (_formKey.currentState!.validate() == true) {
        // if (_dateOfBirth == null) {
        //   ToastUtils.showErrorToast(
        //       context: context,
        //       message: "Please select date of birth!",
        //       icon: const Icon(Icons.error));
        // } else {
        if (_password.text == _confirmPassword.text) {
          SignupModel signupModel = SignupModel(
              userId: 0,
              firstName: _firstName.text,
              lastName: _lastName.text,
              fatherName: _fathersName.text,
              mobileNo: _mobileNumber.text,
              email: _email.text,
              cnic: _cnic.text,
              companyName: _companyName.text,
              password: _password.text,
              dateOfBirth:
                  _dateOfBirth != null ? _dateOfBirth!.toIso8601String() : "");

          var apiResponse = await newUserSignUp(signupModel);

          if (apiResponse.success) {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyOtpComponent(
                    userId: apiResponse.data["userID"].toString(),
                    emailAddress: _email.text,
                    shouldSendOTP: false,
                  ),
                ),
              );
            }
          } else {
            if (mounted) {
              Helpers.showErrorSnackBar(
                  context, apiResponse.message ?? "Something went wrong!");
            }
          }
        } else {
          Helpers.showErrorSnackBar(context, "Passwords do not match!");
        }
        //}
      }
    } catch (e) {
      if (mounted) {
        Helpers.showErrorSnackBar(
            context, e.toString().replaceAll("Exception: ", ""));
      }
    } finally {
      setState(() {
        _isPending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign Up",
                    style: GoogleFonts.raleway(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create an account",
                    style: GoogleFonts.raleway(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _firstName,
                          autofocus: false,
                          hintText: "First Name",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _lastName,
                          autofocus: false,
                          hintText: "Last Name",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _fathersName,
                          autofocus: false,
                          hintText: "Father's Name",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _companyName,
                          autofocus: false,
                          hintText: "Company Name",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _cnic,
                          autofocus: false,
                          hintText: "CNIC",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return "Required";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _mobileNumber,
                          autofocus: false,
                          hintText: "Mobile No",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: DatePickerComponent(
                  //         onDateSelected: (value) {
                  //           _dateOfBirth = value;
                  //         },
                  //         hintText: "Date Of Birth",
                  //         contentPadding: const EdgeInsets.symmetric(
                  //           horizontal: 15.0,
                  //           vertical: 15.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _email,
                          autofocus: false,
                          hintText: "Email",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _password,
                          autofocus: false,
                          hintText: "Password",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                          controller: _confirmPassword,
                          autofocus: false,
                          hintText: "Confirm Password",
                          labelStyle: GoogleFonts.raleway(fontSize: 15),
                          floatingLabelStyle: GoogleFonts.raleway(
                              fontSize: 18, color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 15.0,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: _isPending ? null : _onSubmit,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Constants.primaryColor, width: 1)),
                      width: MediaQuery.of(context).size.width,
                      child: _isPending
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Signing up...",
                                  style: GoogleFonts.raleway(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.raleway(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_isPending) {
                        return;
                      } else {
                        Navigator.of(context).pushNamed("/login");
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Already Have an Account? ',
                            style: GoogleFonts.raleway(
                                color: const Color.fromARGB(255, 151, 151, 151),
                                fontSize: 12),
                          ),
                          TextSpan(
                            text: '  Login',
                            style: GoogleFonts.raleway(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
