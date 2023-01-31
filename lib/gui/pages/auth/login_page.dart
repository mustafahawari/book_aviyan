import 'package:book_aviyan_final/core/utils/loader_widget.dart';
import 'package:book_aviyan_final/gui/common_widgets/error_alert_dialog.dart';
import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/gui/pages/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../feature/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();

      Provider.of<AuthProvider>(context, listen: false)
          .signInWithEmailAndPassword(
        _emailAddress.toLowerCase().trim(),
        _password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Color(0xff90eaed), Color(0xffb8d0d1)],
                    [Color(0xff90eaed), Color(0xffb8d0d1)],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring:
                Provider.of<AuthProvider>(context).status == AuthStatus.loading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      //  color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/5087/5087579.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email Address',
                                fillColor: Colors.white),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            key: ValueKey('Password'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a valid Password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                labelText: 'Password',
                                fillColor: Colors.white),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: _submitForm,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff90eaed)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side:
                                          BorderSide(color: AppColor.mainColor),
                                    ),
                                  )),
                              onPressed: _submitForm,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Colors.black),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(width: 20),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(child: Divider(thickness: 2)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("Don't have account?"),
                            ),
                            Expanded(child: Divider(thickness: 2))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff90eaed)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(color: AppColor.mainColor),
                                  ),
                                )),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp())),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Provider.of<AuthProvider>(context).status == AuthStatus.loading
              ? CenterCircularLoader()
              : SizedBox()
        ],
      ),
    );
  }
}
