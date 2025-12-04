import 'package:flutter/material.dart';
import 'package:kantin_management/components/text_form_field.dart';
import 'package:kantin_management/pages/auth/login.dart';
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

  String ValidateUserDetails(){
    // Implement registration logic here
    String firstName = cFirstName.text.trim();
    String lastName = cLastName.text.trim();
    String email = cEmail.text.trim();
    String password = cPassword.text.trim();
    String confirmPassword = cConfirmPassword.text.trim();

    if( firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      return "Field(s) cannot be empty";
    }

    if( password.length < 8 ){
      return "Password must be at least 8 characters long";
    }

    if(password.length > 30 ){
      return "Password cannot exceed 30 characters";
    }

    if(password != confirmPassword){
      return "Passwords do not match";
    }

    if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)){
      return "Invalid email format";
    }

    return "Success";
  }

  void registerUser(BuildContext context) async {

    String result = ValidateUserDetails();

    if(result == "Success"){
      final response = await ApiServices().registerUser(
        firstName: cFirstName.text,
        lastName: cLastName.text,
        email: cEmail.text,
        password: cPassword.text,
      );

      print(response);
    }else{
      print(result);
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