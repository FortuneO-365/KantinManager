import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kantin_management/screens/auth/login.dart';
import 'package:kantin_management/services/api_services.dart';
import 'package:pinput/pinput.dart';

class EmailVerification extends StatefulWidget {

  final String emailAddress;

  const EmailVerification({
    super.key,
    required this.emailAddress
  });

  @override
  State<StatefulWidget> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification>{

  bool canResend = false;
  int remainingSeconds = 60 * 2;
  final Color mainColor = Color.fromARGB(255, 144, 202, 249);

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

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          canResend = true;
        });
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  void stopTimer(){
    setState(() {
      remainingSeconds = 0;
      canResend = true;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2,'0')}:${secs.toString().padLeft(2,'0')}";
  }

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

  void resendCode () async{
    final data = await ApiServices().resendCode(email: widget.emailAddress);
    if(data.toString() != "Verification code resent. Check your email."){
      showToast(context, "Error sending code try again later");
    }
    setState(() {
      canResend = false;
      remainingSeconds = 60 * 5;
    });
    startTimer();
  }

  void confirmEmail(String pin) async{
    showLoading(context);
    final data = await ApiServices().verifyUser(
      email: widget.emailAddress, 
      verificationCode: pin
    );
    hideLoading(context);
    if(data.toString().toLowerCase().contains("user not found")){
      showToast(context, "User not found");
      return ;
    }

    if(data.toString().toLowerCase().contains("invalid verification code")){
      showToast(context, "Invalid verification code");
      return ;
    }

    showToast(context, "Email verified successfully");
    stopTimer();
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => Login())
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

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
              padding: const EdgeInsets.all(8.0),
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
                      confirmEmail(pin);
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        "Code expires in ",
                      ),
                      Text(
                        "1 hour",
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
                canResend?
                TextButton(
                  onPressed: () {
                    resendCode();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: mainColor,
                    padding: EdgeInsets.all(0),
                    overlayColor: Colors.transparent
                  ),
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                :
                Text(
                  "Resend in ${formatTime(remainingSeconds)}",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}