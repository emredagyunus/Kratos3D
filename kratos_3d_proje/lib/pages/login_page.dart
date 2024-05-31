// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kratos_3d_proje/companents/constants.dart';
import 'package:kratos_3d_proje/companents/my_button.dart';
import 'package:kratos_3d_proje/companents/my_textfield.dart';
import 'package:kratos_3d_proje/pages/create_account_page.dart';
import 'package:kratos_3d_proje/services/auth/auth_gate.dart';
import 'package:kratos_3d_proje/services/auth/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool rememberMeValue = false;

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
  }

  // Load user email and password
  void _loadUserEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMeValue = prefs.getBool('rememberMe') ?? false;
      if (rememberMeValue) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  // Save user email and password
  void _saveUserEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', rememberMeValue);
    if (rememberMeValue) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('email');
      prefs.remove('password');
    }
  }

  // Login method
  void login() async {
    final authService = AuthService();

    // Check whether the information is filled in completely
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Please enter all required information!"),
          ),
        );
      }
      return;
    }
    // Check if email address is valid
    if (!isValidEmail(emailController.text)) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Please enter a valid email address!"),
          ),
        );
      }
      return;
    }
    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthGate(),
          ));
      _saveUserEmailPassword();
    } catch (e) {
      String errorMessage =
          "You entered an invalid email or password, please check!";
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  // Forget password
  void forgetPw() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            // Background image
            image: DecorationImage(
              image: AssetImage('assets/images/Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          // Logo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Image.asset(
                  'assets/images/Logo.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
              // To download the contents to the bottom of the page
              const Spacer(),
              // Email textfield
              SizedBox(
                child: MyTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                ),
              ),
              const SizedBox(height: 10),
              // Password textfield
              SizedBox(
                child: MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  // Password visible
                  obscureText: _obscureText,
                  // Password visible icon
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              // Remember me and forget password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rememberMeValue = !rememberMeValue;
                          });
                        },
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: Constants.greenColor,
                              value: rememberMeValue,
                              onChanged: (newValue) {
                                setState(() {
                                  rememberMeValue = newValue!;
                                });
                              },
                            ),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                color: Constants.yellowColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: forgetPw,
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(
                            color: Constants.yellowColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Login button
              SizedBox(
                width: double.infinity,
                child: MyButton(
                  onTap: login,
                  text: "Login Now",
                  colorBackground: Constants.yellowColor,
                  colorText: Constants.blackColor,
                ),
              ),
              const SizedBox(height: 35),
              // Registration page redirect
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Constants.greyColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateAccountPage(),
                          ));
                    },
                    child: Text(
                      "Create one",
                      style: TextStyle(
                        color: Constants.yellowColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              // Leave space at the bottom of the page and leave space between the content and the page break
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  // Regex pattern to check if email address is in valid format
  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
