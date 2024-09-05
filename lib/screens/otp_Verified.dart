import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerified extends StatefulWidget {
  const OtpVerified({super.key});

  @override
  State<OtpVerified> createState() => _OtpVerifiedState();
}

class _OtpVerifiedState extends State<OtpVerified>
    with SingleTickerProviderStateMixin {
  @override
  final bool _isScaled = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation in a reverse manner

    _animation = Tween<double>(begin: 180, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed("/login");
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
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
                  child: Center(
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return SizedBox(
                                width: _animation.value,
                                height: _animation.value,
                                child: child,
                              );
                            },
                            child: Image.asset("assets/images/otpVerified.jpg"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "OTP Verified Successfully!",
                            style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
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
