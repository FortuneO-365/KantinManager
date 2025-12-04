import 'package:flutter/material.dart';
import 'package:kantin_management/components/text_form_field.dart';
import 'package:kantin_management/main.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/pages/auth/forgot_password.dart';
import 'package:kantin_management/pages/auth/register.dart';
import 'package:kantin_management/services/api_services.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final Color errorColor = Color.fromARGB(255, 239, 154, 154);
  final Color successColor =  Color.fromARGB(255, 165, 214, 167);
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  String validateUserDetails() {
    String email = cEmail.text.trim();
    String password = cPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      return "Field(s) cannot be empty";
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return "Invalid email format";
    }

    return "Success";
  }

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: mainColor,
          backgroundColor: const Color.fromARGB(50, 255, 255, 255),
        ),
      ),
    );
  }

  void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  void login(BuildContext context) async{
    final String validationResult = validateUserDetails();
    if(validationResult != "Success"){
      return ;
    }
    final data = await ApiServices().login(cEmail.text.trim(), cPassword.text.trim());
    if(data){
      showLoading(context);
      User user = await ApiServices().getUser();
      hideLoading(context);
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => HomePage(user: user))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg-pattern.png'),
                    fit: BoxFit.cover,
                  )
                ),
              )
            ),

            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/KANTINFLOW-2.png",
                          width: 140,
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Center(
                        child: Text(
                          "Login with your credentials",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              prefixIcon: Icons.mail_outline,
                              labelText: 'Email',
                              controller: cEmail,
                              isPassword: false,
                            ),
                            SizedBox(height: 16.0),
                            CustomTextFormField(
                              prefixIcon: Icons.lock_outline,
                              labelText: 'Password',
                              controller: cPassword,
                              isPassword: true,
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: mainColor,      // text color
                                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    textStyle: TextStyle(fontSize: 15),
                                    overlayColor: Colors.transparent,
                                  ),
                                  child: Text("Forgot password?"),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.0),
                            ElevatedButton(
                              onPressed: () async {
                                login(context);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(4.0)
                                )
                              ),
                              child: Text('SIGN IN'),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        SizedBox(width: 4.0,),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: mainColor,      // text color
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            textStyle: TextStyle(fontSize: 14),
                            overlayColor: Colors.transparent,
                          ),
                          child: Text("Sign up"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
    );
  }
}