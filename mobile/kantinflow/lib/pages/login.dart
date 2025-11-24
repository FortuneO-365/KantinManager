import 'package:flutter/material.dart';
import 'package:kantin_management/components/custom_alert_dialog.dart';
import 'package:kantin_management/components/text_form_field.dart';
import 'package:kantin_management/main.dart';
import 'package:kantin_management/pages/forgot_password.dart';
import 'package:kantin_management/pages/register.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final Color errorColor = Color.fromARGB(255, 239, 154, 154);
  final Color successColor =  Color.fromARGB(255, 165, 214, 167);
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  String ValidateUserDetails() {
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

  void showErrorPopUp(BuildContext context,String message){
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          Icons.error_outline,
          "Error",
          message, 
          errorColor, 
          "OK",
          () => action(context)
        );
      },
    );
  }

  void action(BuildContext context){
    () => Navigator.of(context, rootNavigator: true).pop();
  }

  void showSuccessPopUp(context){
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          Icons.check_circle_outline,
          "Enter your email",
          "Please check your email for instructions to securely reset your password.", 
          mainColor, 
          "OK",
          () => action(context)
        );
      },
    );
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
                              Icons.person_outline,
                              null,
                              'Email',
                              false,
                              cEmail,
                              decoration: InputDecoration(),
                            ),
                            SizedBox(height: 16.0),
                            CustomTextFormField(
                              Icons.lock_outline,
                              Icons.remove_red_eye_outlined,
                              'Password',
                              true,
                              cPassword,
                              decoration: InputDecoration(),
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
                              onPressed: () {
                                // Handle login action
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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