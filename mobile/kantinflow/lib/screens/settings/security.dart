import 'package:flutter/material.dart';
import 'package:kantin_management/screens/auth/change_password.dart';
import 'package:kantin_management/screens/auth/forgot_password.dart';

class Security extends StatelessWidget{
  const Security({super.key});
  
  final bool look = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 18,
        ),
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        shape: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.white70
          )
        ),
        title: Text(
          "Security",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Color.fromARGB(255, 245, 245, 245),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Passwords"),
            Container(
              margin: EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black87,
                            overlayColor: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Change Password"
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0,),
                  Divider(height: 1.0,),
                  SizedBox(height: 6.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black87,
                            overlayColor: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Forgot Password"
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Text("Biometrics"),
            Container(
              margin: EdgeInsets.fromLTRB(0.0,16.0,0.0,16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black87,
                            overlayColor: Colors.white
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Log in with fingerprint"
                                  ),
                                  Text(
                                    "(Coming soon)",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              ),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                  value: look, 
                                  onChanged: (look){
                                    look = true;
                                  },
                                  inactiveThumbColor: Colors.grey.shade100,
                                  activeThumbColor: Colors.blue.shade300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}