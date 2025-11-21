import 'package:flutter/material.dart';
import 'package:kantin_management/components/text_form_field.dart';
import 'package:kantin_management/pages/email_verification.dart';
import 'package:kantin_management/pages/login.dart';

class Register extends StatelessWidget{
  Register({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);
  final TextEditingController cFirstName  = TextEditingController();
  final TextEditingController cLastName  = TextEditingController();
  final TextEditingController cEmail  = TextEditingController();
  final TextEditingController cPassword  = TextEditingController();
  final TextEditingController cConfirmPassword  = TextEditingController();

  String RegisterUser(){
    // Implement registration logic here
    String firstName = cFirstName.text.trim();
    String lastName = cLastName.text.trim();
    String email = cEmail.text.trim();
    String password = cPassword.text.trim();
    String confirmPassword = cConfirmPassword.text.trim();

    if( firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      return "Bad Request";
    }

    if( password.length < 8 ){
      return "Bad Request";
    }

    if(password.length > 30 ){
      return "Bad Request";
    }

    if(password != confirmPassword){
      // Show error message
      print("Passwords do not match");
      return "Bad Request";
    }

    if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)){
      // Show error message
      print("Invalid email format");
      return "Bad Request";
    }

    return "Success";

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
                    child: Column(
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
                                null,
                                null,
                                'FirstName',
                                false,
                                cFirstName,
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                null,
                                null,
                                'LastName',
                                false,
                                cLastName,
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                null,
                                null,
                                'Email',
                                false,
                                cEmail,
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                null,
                                Icons.remove_red_eye_outlined,
                                'Password',
                                true,
                                cPassword,
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextFormField(
                                null,
                                Icons.remove_red_eye_outlined,
                                'Confirm Password',
                                true,
                                cConfirmPassword,
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: 24.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle login action
                                  String result = RegisterUser();
                                  if(result == "Bad Request"){
                                    return;
                                  }else{
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmailVerification()));
                                  }
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