import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/signup_api.dart';
import 'package:personal_phone_dictionary/components/text_input_component.dart';

class VerifyOtpComponent extends StatefulWidget {
  final String userId;
  final String emailAddress;
  final bool shouldSendOTP;
  const VerifyOtpComponent(
      {super.key,
      required this.userId,
      required this.emailAddress,
      this.shouldSendOTP = true});

  @override
  State<VerifyOtpComponent> createState() => _VerifyOtpComponentState();
}

class _VerifyOtpComponentState extends State<VerifyOtpComponent> {
  TextEditingController optController = TextEditingController();
  String emailAddress = "";
  bool isLoading = false;
  bool issending = false;
  @override
  void initState() {
    emailAddress = widget.emailAddress;
    Future.microtask(() async {
      if (widget.shouldSendOTP == true) {
        await _resendOTP();
      }
    });
    super.initState();
  }

  Future<void> _resendOTP() async {
    setState(() {
      issending = true;
    });
    var apiResponse = await resendOTP(widget.userId);

    if (apiResponse.success == false) {
      {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(apiResponse.message!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP sent successfully!"),
            backgroundColor: Colors.amber,
          ),
        );
      }
    }
    setState(() {
      issending = false;
    });
  }

  Future<void> _verifyOTP() async {
    String msg = "";
    try {
      setState(() {
        isLoading = true;
      });
      msg = await verifyOTP(widget.userId, optController.text);
      if (msg == "") {
        Navigator.of(context).pushNamed("/otpVerfied");
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
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
                      BoxConstraints(minHeight: constraint.maxHeight - 50),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          "assets/images/otpScreen.jpg",
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          "OTP Verification",
                          style: GoogleFonts.raleway(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "The OTP has been to your email. If you don't see it in your inbox, please check your spam folder.",
                          style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextInputComponent(
                                controller: optController,
                                autofocus: false,
                                maxLength: 8,
                                focusedBorderColor: Colors.amber,
                                keyboardType: TextInputType.number,
                                //hintText: "OTP",
                                labelStyle: const TextStyle(fontSize: 15),
                                floatingLabelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
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
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: _verifyOTP,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Center(
                              child: !isLoading
                                  ? const Text(
                                      "Verify",
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
                          onTap: () async {
                            await _resendOTP();
                          },
                          child: Center(
                            child: !issending
                                ? RichText(
                                    text: const TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Didn't receive OTP? ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 151, 151, 151),
                                              fontSize: 12),
                                        ),
                                        TextSpan(
                                          text: '  Send Again.',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )
                                : const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.amber,
                                      strokeWidth: 2,
                                    ),
                                  ),
                          ),
                        ),
                      ],
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
