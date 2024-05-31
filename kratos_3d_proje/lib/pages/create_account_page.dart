import 'package:flutter/material.dart';
import 'package:kratos_3d_proje/companents/constants.dart';
import 'package:kratos_3d_proje/companents/my_button.dart';
import 'package:kratos_3d_proje/companents/my_textfield.dart';
import 'package:kratos_3d_proje/pages/login_page.dart';
import 'package:kratos_3d_proje/services/auth/auth_services.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  //register method
  void register() async {
    final authService = AuthService();

    // Check whether the information is filled in completely
    if (nameController.text.isEmpty ||
        surnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
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

    //check password -> create user
    if (passwordController.text == confirmPasswordController.text) {
      // try creating user
      try {
        await authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
          nameController.text,
          surnameController.text,
        );
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } catch (e) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      }
    }
    //if password don't match -> show error
    else {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Şifreler eşleşmiyor, tekrar dene!"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(70.0),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: Constants.yellowColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: nameController,
                  hintText: "Name",
                  obscureText: false,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: surnameController,
                  hintText: "Surname",
                  obscureText: false,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: "Email Address",
                  obscureText: false,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: false,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: false,
                  maxLines: 1,
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                      text: "Create Account",
                      onTap: register,
                      colorBackground: Constants.yellowColor,
                      colorText: Constants.blackColor,
                    ),
                    const SizedBox(height: 10),
                    MyButton(
                      text: "Cancel",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      colorBackground: Constants.redColor,
                      colorText: Constants.whiteColor,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Regex pattern to check if email adress is in valid format
  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
