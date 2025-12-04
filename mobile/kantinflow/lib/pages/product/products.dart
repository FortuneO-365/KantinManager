import 'package:flutter/material.dart';
import 'package:kantin_management/components/product.dart';
import 'package:kantin_management/pages/product/add_product.dart';

class Products extends StatelessWidget {
  Products({super.key});

  final Color mainColor = Color.fromARGB(255, 144, 202, 249);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          Positioned.fill(
            child: Container(
              color: Color.fromARGB(255, 245, 245, 245),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  child: Text(
                    "All Products",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade300
                          ),
                          color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Products",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              "10",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade300
                          ),
                          color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Value",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              "\$257.38",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade300
                          ),
                          color: Colors.white
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Low Stock",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Text(
                              "3",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextSelectionTheme(
                        data: TextSelectionThemeData(),
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            hintText: "Search",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      onPressed: () {
          
                      },
                      style: IconButton.styleFrom(
                        hoverColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(12.0)
                      ),
                      icon: Icon(
                        Icons.filter_alt_outlined
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: ListView(
                    children: [
                      Product(
                        "Coca-Cola",
                        "30",
                        "1.99",
                        false
                      ),
                      Product(
                        "Fanta",
                        "15",
                        "5.00",
                        false
                      ),
                      Product(
                        "Egg",
                        "5",
                        "10.00",
                        true
                      ),
                      Product(
                        "Mint-tea",
                        "3",
                        "10.00",
                        true
                      ),
                      Product(
                        "Rice",
                        "20",
                        "15.00",
                        false
                      ),
                      Product(
                        "Spirit",
                        "35",
                        "2.00",
                        false
                      ),
                      Product(
                        "Pepsi",
                        "30",
                        "15.00",
                        false
                      ),
                      Product(
                        "Bread",
                        "30",
                        "5.99",
                        false
                      ),
                      Product(
                        "Gum",
                        "1",
                        "0.89",
                        true
                      ),
                      Product(
                        "Coconut",
                        "30",
                        "5.20",
                        false
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          Positioned(
            bottom: 36.0,
            right: 26.0,
            child: IconButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: mainColor
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                
              )
            )
          )
        ]
      )
    );
  }
}
