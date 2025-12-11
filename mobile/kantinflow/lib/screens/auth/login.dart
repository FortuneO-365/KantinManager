import 'package:flutter/material.dart';
import 'package:kantin_management/widgets/text_form_field.dart';
import 'package:kantin_management/main.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/screens/auth/email_verification.dart';
import 'package:kantin_management/screens/auth/forgot_password.dart';
import 'package:kantin_management/screens/auth/register.dart';
import 'package:kantin_management/services/api_services.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final Color errorColor = Color.fromARGB(255, 239, 154, 154);
  final Color successColor =  Color.fromARGB(255, 165, 214, 167);
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  String validateUserDetails(BuildContext context) {
    String email = cEmail.text.trim();
    String password = cPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showToast(context, "Field(s) cannot be empty");
      return "Field(s) cannot be empty";
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      showToast(context, "Invalid email format");
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

  void showToast(BuildContext context,String message){
    // Implement toast message display
      OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0, // Position from the bottom
        left: MediaQuery.of(context).size.width * 0.1, // Center horizontally
        right: MediaQuery.of(context).size.width * 0.1, // Center horizontally
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context).insert(overlayEntry);

    // Remove the overlay entry after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void login(BuildContext context) async{
    final String validationResult = validateUserDetails(context);
    if(validationResult != "Success"){
      return ;
    }
    final data = await ApiServices().login(cEmail.text.trim(), cPassword.text.trim());
    print(data.toString());
    if(data.toString() == "Success"){
      showLoading(context);
      User user = await ApiServices().getUser();
      hideLoading(context);
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (_) => HomePage(user: user))
      );
    }else if(data.toString().toLowerCase().contains("verify your email")){
      showToast(context, "Email not verified. Redirecting...");
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (_) => EmailVerification(emailAddress: cEmail.text.trim(),))
        );
      });
    }else if(data.toString().toLowerCase().contains("invalid credentials")){
      showToast(context, "Email or password is incorrect");
    }else{
      showToast(context, "Something went wrong. Try again later");
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