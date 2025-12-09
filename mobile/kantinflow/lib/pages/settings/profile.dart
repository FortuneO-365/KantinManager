import 'package:flutter/material.dart';

class Profile extends StatefulWidget{

  final String firstName;
  final String lastName;
  final String email;

  const Profile({
    super.key, 
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final TextEditingController _controller = TextEditingController();

  String hideEmail(String email){
    String firstThreeLetters = email.substring(0,3);
    String lastThreeLetters = email.split('@')[1];
    return "$firstThreeLetters****$lastThreeLetters";
  }

  void _showPicker(BuildContext context, String title, TextEditingController controller) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Edit $title",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextSelectionTheme(
                      data: TextSelectionThemeData(
                        selectionColor: Colors.grey.shade400,
                        cursorColor: Colors.grey.shade600,
                        selectionHandleColor: Colors.black,
                      ),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(
                            color: Colors.grey.shade300
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2.0
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ),
                        child: Text("Cancel")
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade300,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0)
                          )
                        ),
                        child: Text("Edit")
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showImagePicker(BuildContext context){
    
  }
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
      body: ListView(
        children: [
          Container(
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
                            Text(
                              widget.firstName,
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
                        onPressed: (){
                          setState(() {
                            _controller.text = widget.firstName;
                          });
                          _showPicker(context, "Firstname", _controller);
                        }, 
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
                                  widget.firstName,
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
                        onPressed: (){
                          setState(() {
                            _controller.text = widget.lastName;
                          });
                          _showPicker(context, "Lastname", _controller);
                        }, 
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
                                  widget.lastName,
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
                                  hideEmail(widget.email),
                                ),
                              ],
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10.0,),
                      TextButton(
                        onPressed: (){
                          
                        }, 
                        style: TextButton.styleFrom(
                          overlayColor: Colors.white,
                          foregroundColor: Colors.blue.shade300
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "",
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
                              "Number",
                              style: TextStyle(
                                color: Color.fromARGB(255, 70, 70, 70),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "",
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
        ],
      ),
    );
  }
}
