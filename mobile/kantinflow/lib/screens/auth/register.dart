import 'package:flutter/material.dart';
import 'package:kantin_management/widgets/text_form_field.dart';
import 'package:kantin_management/screens/auth/email_verification.dart';
import 'package:kantin_management/screens/auth/login.dart';
import 'package:kantin_management/services/api_services.dart';

class Register extends StatelessWidget{
  Register({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final Color errorColor = Color.fromARGB(255, 239, 154, 154);
  final Color successColor =  Color.fromARGB(255, 165, 214, 167);
  final TextEditingController cFirstName  = TextEditingController();
  final TextEditingController cLastName  = TextEditingController();
  final TextEditingController cEmail  = TextEditingController();
  final TextEditingController cPassword  = TextEditingController();
  final TextEditingController cConfirmPassword  = TextEditingController();

  bool validateUserDetails(BuildContext context){
    // Implement registration logic here
    String firstName = cFirstName.text.trim();
    String lastName = cLastName.text.trim();
    String email = cEmail.text.trim();
    String password = cPassword.text.trim();
    String confirmPassword = cConfirmPassword.text.trim();

    if( firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      showToast(context,"Field(s) cannot be empty");
      return false;
    }

    if( password.length < 8 ){
      showToast(context,"Password must be at least 8 characters long");
      return false;
    }

    if(password.length > 30 ){
      showToast(context,"Password cannot exceed 30 characters");
      return false;
    }

    if(password != confirmPassword){
      showToast(context,"Passwords do not match");
      return false;
    }

    if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)){
      showToast(context,"Invalid email format");
      return false;
    }

    return true;
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

  void registerUser(BuildContext context) async {

    if(validateUserDetails(context)){
      showLoading(context);
      final data = await ApiServices().registerUser(
        firstName: cFirstName.text,
        lastName: cLastName.text,
        email: cEmail.text,
        password: cPassword.text,
      );
      hideLoading(context);
      if(data.toString() == "User Registered Successfully. Check your mail for a verification code"){

        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => EmailVerification(emailAddress: cEmail.text,))
        );
      }else{
        hideLoading(context);
        showToast(context, "User Registration Failed. Try again later.");
      }
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
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                labelText: 'Firstname',
                                controller: cFirstName,
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                labelText: 'Lastname',
                                controller: cLastName,
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                labelText: 'Email',
                                controller: cEmail,
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                labelText: 'Password',
                                controller: cPassword,
                                isPassword: true,
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                labelText: 'Confirm Password',
                                controller: cConfirmPassword,
                                isPassword: true,
                              ),
                              SizedBox(height: 24.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle login action
                                  registerUser(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 50),
                                  backgroundColor: mainColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(4.0)
                                  )
                                ),
                                child: Text('CREATE ACCOUNT'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        SizedBox(width: 4.0,),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: mainColor,      // text color
                            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            textStyle: TextStyle(fontSize: 14),
                            overlayColor: Colors.transparent,
                          ),
                          child: Text("Sign in"),
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