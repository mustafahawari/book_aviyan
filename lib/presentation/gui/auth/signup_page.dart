import 'package:book_aviyan_final/core/utils/ToastUtils.dart';
import 'package:book_aviyan_final/data/models/user_model/user_model.dart';
import 'package:book_aviyan_final/core/consts/colors.dart';
import 'package:book_aviyan_final/presentation/gui/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../core/utils/loader_widget.dart';
import '../../feature/auth_provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      UserModel userModel = UserModel(
        fullName: _fullName,
        phoneNumber: _phoneNumber,
        email: _emailAddress,
      );
      await Provider.of<AuthProvider>(context, listen: false)
          .signUpWithEmailAndPassword(userModel, _password);
      final prov = Provider.of<AuthProvider>(context, listen: false);
      if (prov.status == AuthStatus.error) {
        ToastUtils.showToast(prov.errorMessage!, ToastType.ERROR);
      } else if (prov.status == AuthStatus.success) {
        Navigator.pop(context);
      }
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
                    [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.primaryContainer
                    ],
                    [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.primaryContainer
                    ],
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
            ignoring: Provider.of<AuthProvider>(context).status == AuthStatus.loading,
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
                          'https://cdn-icons-png.flaticon.com/512/2037/2037710.png',
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
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            key: ValueKey('name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name cannot be empty';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_phoneNumberFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Full Name',
                              fillColor: Colors.white,
                            ),
                            onSaved: (value) {
                              _fullName = value!;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            focusNode: _phoneNumberFocusNode,
                            key: ValueKey('number'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone number cannot be empty';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.phone_android),
                              labelText: 'Phone Number',
                              fillColor: Colors.white,
                            ),
                            onSaved: (value) {
                              _phoneNumber = int.parse(value!);
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            focusNode: _emailFocusNode,
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
                              fillColor: Colors.white,
                            ),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
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
                              fillColor: Colors.white,
                            ),
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: _obscureText,
                            onEditingComplete: _submitForm,
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side: BorderSide(
                                      color: AppColor.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: _submitForm,
                              child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(child: Divider(thickness: 2)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("OR"),
                              ),
                              Expanded(child: Divider(thickness: 2))
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                                foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.onPrimary),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: AppColor.mainColor),
                                    ),
                                  )),
                              onPressed: () => Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage())),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
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
