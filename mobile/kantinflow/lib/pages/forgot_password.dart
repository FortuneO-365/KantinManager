import 'package:flutter/material.dart';
import 'package:kantin_management/components/text_form_field.dart';

class ForgotPassword extends StatelessWidget{
  ForgotPassword({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final TextEditingController cEmail = TextEditingController();

  void showMyPopUp(context){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: 
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: Icon(
              Icons.mail_outline,
              size: 30.0,
            ),
          ),
          content: SizedBox(
            height: 90.0,
            child: Column(
              children: [
                Text(
                  "Check your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "Please check your email for instructions to securely reset your password.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // your action
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResetForgottenPassword()));
              },
              style: TextButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("CHECK EMAIL"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 249, 252),
      body: Stack(
        children: [
          Positioned(
            top: 16,
            left: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              child: Icon(
                Icons.chevron_left_rounded,
                color: Colors.black,
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: const Text("Forgot Password", 
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CustomTextFormField(
                    Icons.mail_outline,
                    null,
                    'Enter your email',
                    false,
                    cEmail,
                    decoration: const InputDecoration(),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      showMyPopUp(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4.0)
                      )
                    ),
                    child: Text('SUBMIT'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ResetForgottenPassword extends StatelessWidget{
  ResetForgottenPassword({super.key});
  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final TextEditingController cNewPassword = TextEditingController();
  final TextEditingController cConfirmNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 249, 252),
      body: Stack(
        children: [
          Positioned(
            top: 16,
            left: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
              ),
              child: Icon(
                Icons.chevron_left_rounded,
                color: Colors.black,
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: const Text("Reset Your Password", 
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CustomTextFormField(
                    Icons.lock_outline,
                    null,
                    'Enter your new password',
                    true,
                    cNewPassword,
                    decoration: const InputDecoration(),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Confirm New Password',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CustomTextFormField(
                    Icons.lock_outline,
                    null,
                    'Confirm your new password',
                    true,
                    cConfirmNewPassword,
                    decoration: const InputDecoration(),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4.0)
                      )
                    ),
                    child: Text('SUBMIT'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}