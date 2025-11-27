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
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Items",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {}, 
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 16,
                          color: mainColor,
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: ListView(
                    children: [
                      Product(
                        "Coca-Cola",
                        "30",
                        "1.99"
                      ),
                      Product(
                        "Fanta",
                        "15",
                        "5.00"
                      ),
                      Product(
                        "Egg",
                        "5",
                        "10.00"
                      ),
                      Product(
                        "Mint-tea",
                        "30",
                        "10.00"
                      ),
                      Product(
                        "Rice",
                        "20",
                        "15.00"
                      ),
                      Product(
                        "Spirit",
                        "35",
                        "2.00"
                      ),
                      Product(
                        "Pepsi",
                        "30",
                        "15.00"
                      ),
                      Product(
                        "Bread",
                        "30",
                        "5.99"
                      ),
                      Product(
                        "Gum",
                        "30",
                        "0.89"
                      ),
                      Product(
                        "Coconut",
                        "30",
                        "5.20"
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
