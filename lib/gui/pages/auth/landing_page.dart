import 'package:book_aviyan_final/gui/common_widgets/error_alert_dialog.dart';
import 'package:book_aviyan_final/gui/pages/auth/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          final User _user = _auth.currentUser!;
          final _uid = _user.uid;

          FirebaseFirestore.instance.collection("users").doc(_uid).set(
            {
              "id": _uid,
              "name": _user.displayName,
              "email": _user.email,
              "phoneNumber": "",
              "joinedAt": Timestamp.now(),
              "imageUrl": _user.photoURL,
            },
          );
        } on FirebaseAuthException catch (e) {
          print(e.message);
          ErrorDialog.authErrorHandle(e.message!, context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset(
                "assets/images/landing.png",
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    CustomizedButton(
                      title: "Login",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomizedButton(
                      isGoogleButton: true,
                      title: "Sign In with Google",
                      onPressed: googleSignIn,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomizedButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final bool isGoogleButton;
  const CustomizedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isGoogleButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff90eaed)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isGoogleButton
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Image.asset("assets/images/google.png",
                        height: 40, width: 40, fit: BoxFit.cover),
                  )
                : Text(""),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
