import 'package:flutter/material.dart';
import 'package:kantin_management/components/counter_input.dart';

class Sales extends StatelessWidget {
  const Sales({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sales",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
                TextButton(
                  onPressed: (){},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue.shade300
                  ), 
                  child: Text("History")
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(85, 100, 180, 246),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    SizedBox(width: 16.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Sale",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text("Record a transaction"),
                      ],
                    )
                  ],
                ),

                SizedBox(height: 8.0,),
                Divider(),
                SizedBox(height: 12.0,),

                Container(
                  child: Column(
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
                      items: ["Coca-Cola", "Rice", "Mint-Tea", "Bread"]
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              )) 
                          .toList(),
                      onChanged: (item) {}
                      
                    ),
                    ],
                  ),

                ),

                CounterInput(
                  value: 0,
                  onIncrement: () {},
                  onDecrement: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
