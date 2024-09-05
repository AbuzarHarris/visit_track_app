import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/api/login_api.dart';
import 'package:personal_phone_dictionary/components/verify_otp_component.dart';
import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/login_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      try {
        setState(() {
          isLoading = true;
        });
        ApiResponse<LoginModel, LoginErrorModel> apiResponse =
            await loginusercheck(username, password);
        if (apiResponse.success) {
          LoginModel data = apiResponse.data!;
          SecureStorage secureStorage = SecureStorage();
          secureStorage.writeSecureData("userID", data.userID.toString());
          secureStorage.writeSecureData("companyID", data.companyID.toString());
          secureStorage.writeSecureData("email", data.email.toString());
          secureStorage.writeSecureData("firstName", data.firstName);
          secureStorage.writeSecureData("lastName", data.lastName);
          secureStorage.writeSecureData("isAdmin", data.isAdmin.toString());

          if (mounted) {
            Navigator.of(context).pushNamed("/dashboard");
          }
        } else {
          if (apiResponse.errCode == "UNAPPROVED") {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  action: SnackBarAction(
                    label: "Verify Now?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyOtpComponent(
                            userId: apiResponse.data!.userID.toString(),
                            emailAddress: apiResponse.data!.email.toString(),
                          ),
                        ),
                      );
                    },
                  ),
                  content: Text(apiResponse.message!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll("Exception: ", "")),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _sendOTP(int saleVoucherID) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(
              Icons.star,
              color: Colors.amber,
              size: 50,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            content: const Text(
              "Do you want to acknowledge the delivery?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            actions: [
              GestureDetector(
                  onTap: () {
                    // postData(saleVoucherID);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text("No"),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(minHeight: constraint.maxHeight - 30),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            "assets/images/logo.png",
                            width: 250,
                            height: 250,
                          ),
                          const SizedBox(
                            height: 75,
                          ),
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Constants.primaryColor,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                labelText: "Email"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !showPassword,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                child: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Constants.primaryColor,
                                ),
                              ),
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the passowrd";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: _login,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: MediaQuery.of(context).size.width - 100,
                              child: Center(
                                child: !isLoading
                                    ? const Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed("/signup");
                            },
                            child: RichText(
                              text: const TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Didn't have an account? ",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 151, 151),
                                        fontSize: 12),
                                  ),
                                  TextSpan(
                                    text: '  Sign Up',
                                    style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Spacer(),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Developed By ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 151, 151, 151),
                                      fontSize: 12),
                                ),
                                TextSpan(
                                    text: 'Edusoft System Solutions',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 151, 151, 151),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                            "http://www.edusoftsolutions.com"));
                                      })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
