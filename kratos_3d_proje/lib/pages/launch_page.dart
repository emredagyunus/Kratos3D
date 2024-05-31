// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kratos_3d_proje/companents/constants.dart';
import 'package:kratos_3d_proje/pages/login_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Showing for 5 seconds and redirecting to the login page
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  //view gif
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      body: Center(
        child: Image.asset('assets/gif/launch_gif.gif'),
      ),
    );
  }
}
