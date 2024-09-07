import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/components/bottom_navigation_bar.dart';
import 'package:personal_phone_dictionary/screens/add_new_contact.dart';
import 'package:personal_phone_dictionary/screens/area_list_screen.dart';
import 'package:personal_phone_dictionary/screens/client_list_screen.dart';
import 'package:personal_phone_dictionary/screens/home_screen.dart';
import 'package:personal_phone_dictionary/screens/login_screen.dart';
import 'package:personal_phone_dictionary/screens/otp_Verified.dart';
import 'package:personal_phone_dictionary/screens/reference_type_screen.dart';
import 'package:personal_phone_dictionary/screens/references_screen.dart';
import 'package:personal_phone_dictionary/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visit Track',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        scaffoldBackgroundColor: Colors.white,
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.all(8),
              constraints: BoxConstraints(maxHeight: 30)),
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignUpScreen(),
        "/dashboard": (context) => CustomBottomNavigationBar(),
        "/addnewcontact": (context) => const AddNewContact(),
        "/otpVerfied": (context) => const OtpVerified(),
        "/arealist": (context) => const AreaListScreen(),
        "/referencetypelist": (context) => const ReferenceTypeScreen(),
        "/referenceslist": (context) => const ReferencesScreen(),
        "/clientslist": (context) => const ClientListScreen(),
      },
    );
  }
}
