import 'package:flutter/material.dart';
import 'package:kantin_management/pages/auth/login.dart';
import 'package:kantin_management/pages/sales/sales_history.dart';
import 'package:kantin_management/pages/settings/profile.dart';
import 'package:kantin_management/pages/settings/security.dart';

class Settings extends StatelessWidget{

  final String firstName;
  final String lastName;
  final String email;

  const Settings({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4DA0FF),
                    Color(0xFF77E8FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 245, 245, 245),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0,),
              Container(
                padding:  const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile.png",
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(width: 12.0),
                        Text(
                          '$firstName $lastName',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 2.0),
                      child: Text(
                        "Account"
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
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
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => Profile(
                                          firstName: firstName,
                                          lastName: lastName,
                                          email: email,
                                        )
                                      )
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    overlayColor: Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Profile"
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Security()));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    overlayColor: Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Security"
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 2.0),
                      child: Text(
                        "Notification & Themes"
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SalesHistory()));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    overlayColor: Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Transaction History"
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
                                  onPressed: (){},
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    overlayColor: Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Notification Settings"
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
                                  onPressed: (){},
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black87,
                                    overlayColor: Colors.white
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Themes"
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
                          )
                        ]
                      )
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ), 
                        child: Text("Sign Out")
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}