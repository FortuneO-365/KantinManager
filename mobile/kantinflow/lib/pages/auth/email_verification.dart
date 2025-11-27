import 'package:flutter/material.dart';
import 'package:kantin_management/pages/auth/login.dart';
import 'package:pinput/pinput.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final defaultPinTheme = PinTheme(
    width: 48,
    height: 56,
    textStyle: TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 249, 252),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Expanded(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Email Verification",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 42.0),
                    Center(
                      child: Text(
                        "Please enter the 6-digit code sent to your email address.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: mainColor),
                        ),
                      ),
                      onCompleted: (pin) {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text(
                          "Code expires in ",
                        ),
                        Text(
                          "02:00",
                          style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn't receive the code?",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Resend code logic here
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: mainColor, // text color
                  ),
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}