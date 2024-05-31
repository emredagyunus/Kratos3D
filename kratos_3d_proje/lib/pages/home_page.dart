import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kratos_3d_proje/companents/constants.dart';
import 'package:kratos_3d_proje/companents/my_button.dart';
import 'package:kratos_3d_proje/services/auth/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();

  // logout
  void logout() async {
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  // We get the user's name and surname from firebase
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Text('No user data');
                      }

                      var userData =
                          snapshot.data!.data() as Map<String, dynamic>?;
                      if (userData == null) {
                        return const Text('User data is empty');
                      }

                      var fullName =
                          "${userData['name']} ${userData['surname']}";

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Constants.yellowColor,
                            size: 36,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            fullName,
                            style: TextStyle(
                                color: Constants.yellowColor,
                                fontSize: 26,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              MyButton(
                onTap: logout,
                text: "Logout",
                colorBackground: Constants.yellowColor,
                colorText: Constants.blackColor,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
