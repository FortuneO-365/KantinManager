import 'package:flutter/material.dart';
import 'package:kantin_management/models/user.dart';
import 'package:kantin_management/screens/auth/login.dart';
import 'package:kantin_management/screens/notification/notification_setttings.dart';
import 'package:kantin_management/screens/sales/sales_history.dart';
import 'package:kantin_management/screens/settings/profile.dart';
import 'package:kantin_management/screens/settings/security.dart';
import 'package:kantin_management/services/api_services.dart';

// ignore: must_be_immutable
class Settings extends StatefulWidget{

  User user;

  Settings({
    super.key,
    required this.user
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
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

  void signOut(BuildContext context) async{
    final data = await ApiServices().logout();

    if(data.toString() == "Logged out successfully"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }else{
      showToast(context, "Error signing out");
    }
  }

  void getUser() async {
    User newUser = await ApiServices().getUser();
    setState(() {
      widget.user = newUser;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

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
                            widget.user.profileImageUrl != null
                            ?
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.user.profileImageUrl!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              ),
                              child: Image.network(
                                widget.user.profileImageUrl!,
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            )
                            :
                            Image.asset(
                              "assets/images/profile.png",
                              width: 60,
                              height: 60,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              '${widget.user.firstName} ${widget.user.lastName}',
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
                                              user: widget.user,
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
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSetttings()));
                                      },
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
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Themes"
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
                              signOut(context);
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