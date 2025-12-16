import 'package:flutter/material.dart';
import 'package:kantin_management/widgets/text_form_field.dart';
import 'package:kantin_management/screens/auth/login.dart';
import 'package:kantin_management/services/api_services.dart';

class ForgotPassword extends StatelessWidget{
  ForgotPassword({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final TextEditingController cEmail = TextEditingController();

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


  bool validateEmail(BuildContext context){
    String email = cEmail.text.trim();
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);


    if(email.isEmpty){
      showToast(context, "Email cannot be empty");
      return false;
    }


    if(!regex.hasMatch(email)){
      showToast(context, "Invalid email format");
      return false;
    }
    
    return true;
  }

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
                  "Enter your email",
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

  void initiateForgotPassword(BuildContext context) async{
    if(!validateEmail(context)){
      return ;
    }

    showLoading(context);
    final data = await ApiServices().initiateForgotPassword(
      email: cEmail.text
    );
    hideLoading(context);

    if(data.toString() != "Password reset instructions sent if the email exists."){
      showToast(context, "Unable to send reset email. Try again later");
      return ;
    }

    showMyPopUp(context);
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
                    prefixIcon: Icons.mail_outline,
                    labelText: 'Email',
                    controller: cEmail,
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      initiateForgotPassword(context);
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
  final TextEditingController cCode = TextEditingController();

  
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

  bool validateinput(BuildContext context){
    String code = cCode.text.trim();
    String newPassword = cNewPassword.text.trim();
    String confirmNewPassword = cConfirmNewPassword.text.trim();

    if(code.isEmpty){
      showToast(context, "Code can't be empty");
      return false;
    }

    if(newPassword.isEmpty){
      showToast(context, "New Password can't be empty");
      return false;
    }

    if(confirmNewPassword.isEmpty){
      showToast(context, "Confirm New Password can't be empty");
      return false;
    }

    if(newPassword != confirmNewPassword){
      showToast(context, "Passwords do not match");
      return false;
    }

    return true;
  }

  void completeForgotPassword(BuildContext context) async{
    if(!validateinput(context)){
      return ;
    }
    

    showLoading(context);
    final data = await ApiServices().completeForgotPassword(
      code: cCode.text,
      password: cNewPassword.text,
    );
    hideLoading(context);

    if(data.toString() != "Password Changed Successfully"){
      if(data.toString() == "Invalid or expired code."){
        showToast(context, "Invalid or expired code.");
        return ;
      }else{
        showToast(context, "Unable to reset password. Try again later");
        return ;
      }
    }
    showToast(context, "Password reset successfully. Please login with your new password.");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 249, 252),
      body: Container(
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
                    'Code',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              CustomTextFormField(
                prefixIcon: Icons.numbers,
                labelText: 'Code',
                controller: cCode,
              ),
              SizedBox(height: 16.0),
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
                prefixIcon: Icons.lock_outline,
                labelText: 'New Password',
                controller: cNewPassword,
                isPassword: true,
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
                prefixIcon: Icons.lock_outline,
                labelText: 'Confirm new Password',
                controller: cConfirmNewPassword,
                isPassword: true,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  completeForgotPassword(context);
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
    );
  }
}