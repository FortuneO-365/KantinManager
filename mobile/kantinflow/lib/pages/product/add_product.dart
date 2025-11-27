import 'package:flutter/material.dart';
import 'package:kantin_management/components/product_text_field.dart';

class AddProduct extends StatelessWidget{
  AddProduct({super.key});

  final TextEditingController cName = TextEditingController();

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
          "Add Product",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color.fromARGB(127, 187, 222, 251)
                  ),
                  child: Icon(
                    Icons.inventory_2_outlined
                  ),
                ),
                SizedBox(width: 16.0,),
                Column(
                  children: [
                    Text(
                      "Product Information",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                      ),
                    ),
                    Text("Fill in all required fields"),
                  ],
                )
              ],
            ),

            SizedBox(height: 16.0),
            Divider(),
            SizedBox(height: 16.0),

            Column(
              children: [
                ProductTextField(
                  title: "Product Name", 
                  hint: "e.g Wireless Mouse", 
                  keyboardType: TextInputType.text,
                  controller: cName
                ),
                SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Currency",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade300
                          )
                        ),
                      ),
                      items: ["Nigerian Naira (NGN)", "US Dollar (USD)", "Euro (EUR)", "British Pound (GBP)"]
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              )) 
                          .toList(),
                      onChanged: (item) {}
                      
                    )
                  ]
                ),
                SizedBox(height: 16.0),
                ProductTextField(
                  title: "Price", 
                  hint: "0.00", 
                  keyboardType: TextInputType.number,
                  controller: cName
                ),
                SizedBox(height: 16.0),
                ProductTextField(
                  title: "Quantity", 
                  hint: "0", 
                  keyboardType: TextInputType.number,
                  controller: cName
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: (){}, 
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue.shade300,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4.0)
                    )
                  ),
                  child: Text("ADD TO INVENTORY",)
                )
              ],
            )
          ],
        )
      ),
    );
  }
}