import 'package:flutter/material.dart';

class Profile extends StatelessWidget{
  const Profile({super.key});

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
          "My Profile",
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
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile.png",
                          width: 130,
                          height: 130,
                        ),
                        const Text(
                          "Micheal",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {}, 
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8.0)
                            ),
                          ),
                          child: Text(
                            "Edit"
                          )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  TextButton(
                    onPressed: (){}, 
                    style: TextButton.styleFrom(
                      overlayColor: Colors.white,
                      foregroundColor: Colors.blue.shade300
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Firstname",
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Micheal",
                            ),
                            SizedBox(width: 4.0,),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0,
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 10.0,),
                  TextButton(
                    onPressed: (){}, 
                    style: TextButton.styleFrom(
                      overlayColor: Colors.white,
                      foregroundColor: Colors.blue.shade300
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Lastname",
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Scott",
                            ),
                            SizedBox(width: 4.0,),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0,
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 10.0,),
                  TextButton(
                    onPressed: (){}, 
                    style: TextButton.styleFrom(
                      overlayColor: Colors.white,
                      foregroundColor: Colors.blue.shade300
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "fort***ail.com",
                            ),
                            SizedBox(width: 4.0,),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0,
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 10.0,),
                  TextButton(
                    onPressed: (){}, 
                    style: TextButton.styleFrom(
                      overlayColor: Colors.white,
                      foregroundColor: Colors.blue.shade300
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Password",
                          style: TextStyle(
                            color: Color.fromARGB(255, 70, 70, 70),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "**********",
                              style: TextStyle(
                                
                              ),
                            ),
                            SizedBox(width: 4.0,),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0,
                            )
                          ],
                        )
                      ],
                    )
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
