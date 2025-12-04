import 'package:flutter/material.dart';
import 'package:kantin_management/components/counter_input.dart';
import 'package:kantin_management/pages/sales/sales_history.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});
  
  @override
  SalesState createState() => SalesState();
}

class SalesState extends State<Sales> {

  bool isSelected = false;

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
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SalesHistory()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue.shade300
                  ), 
                  child: Text("History")
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
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
                
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select product",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                                ),
                              ),
                              SizedBox(height: 8.0),
                              DropdownButtonFormField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300
                                    )
                                  ),
                                  enabledBorder: OutlineInputBorder(
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
                                onChanged: (item) {
                                  setState(() {
                                    isSelected = true;
                                  });
                                }
                                
                              ),
                            ],
                          ),
                        ],
                      ),
                
                      SizedBox(height: 16.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0
                            ),
                          ),
                          SizedBox(height: 8.0),
                          CounterInput(
                            value: 1,
                            onIncrement: () {},
                            onDecrement: () {},
                          ),
                        ]
                      ),
                      SizedBox(height: 16.0,),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(8.0),
                          border: BoxBorder.all(
                            color: Colors.grey.shade300
                          )
                        ),
                        child: isSelected ? 
                        Row(
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 16.0,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Product Name"),
                                SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0
                                          ),
                                        ),
                                        Text("\$12.00")
                                      ],
                                    ),
                                    SizedBox(width: 40.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Stock",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.0
                                          ),
                                        ),
                                        Text("23 units")
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                        :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Preview",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0
                              ),
                            ),
                            SizedBox(height: 12.0,),
                            Text(
                              "No product selected",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 16.0,),
                      Container(
                        child: isSelected ? 
                          Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(192, 187, 222, 251),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.blue.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment. start,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_rounded,
                                          size: 14.0,
                                        ),
                                        SizedBox(width: 4.0,),
                                        Text("1 × \$12.00")
                                      ],
                                    )
                                  ],
                                ),
                
                                Text(
                                  "\$12.00",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                )
                              ],
                            ),
                          )
                          :
                          Container(),
                      ),
                
                      SizedBox(height: 16.0,),
                      Container(),
                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade300,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8.0),
                              )
                            ), 
                            child: Text(
                              "Record Sale"
                            )
                          ),
                        ],
                      )
                
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
