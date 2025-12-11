import 'package:flutter/material.dart';

class NotificationSetttings extends StatelessWidget {
  const NotificationSetttings({super.key});

  final bool look = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
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
          "Notification Settings",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enable Notifications"),
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
                                    "Enable app notifications",
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
            )
          ],
        ),
      ),
    );
  }
}