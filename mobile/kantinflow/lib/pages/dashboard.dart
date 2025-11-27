import 'package:flutter/material.dart';
import 'package:kantin_management/components/low_stock_product.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg-pattern.png'),
                    fit: BoxFit.cover,
                  )
                ),
              )
            ),

          Column(
            children: [
              Container(
                padding:  const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile.png",
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 12.0),
                        const Text(
                          "Hello, MICHEAL!",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.blue.shade100
                          ),
                          icon: const Icon(
                            Icons.notifications, 
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Notification action
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 2.0,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(16.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: AlignmentGeometry.topLeft,
                                  end: AlignmentGeometry.bottomRight,
                                  colors: [
                                    Colors.blue.shade100,
                                    Colors.grey.shade100,
                                  ]
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.blueGrey
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Sales"),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(16.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: AlignmentGeometry.topRight,
                                  end: AlignmentGeometry.bottomLeft,
                                  colors: [
                                    Colors.blue.shade100,
                                    Colors.grey.shade100,
                                  ]
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.blueGrey
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Revenue"),
                                  Text(
                                    "\$0.00",
                                    style: TextStyle(
                                      fontSize: 20.0
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                
                      SizedBox(height: 2.0,),
                      Container(
                        margin: EdgeInsets.all(16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(58, 33, 150, 243),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sales Overview",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                            SizedBox(height: 20.0,),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white54
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(58, 33, 150, 243),
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        child: Icon(Icons.currency_pound_outlined)
                                      ),
                                      SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Today's Sales"),
                                          Text(
                                            "\$0.00",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          Text("0 transactions"),
                                        ],
                                      ),
                                    ],
                                  ),
                
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14.0,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white54
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(58, 33, 150, 243),
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        child: Icon(Icons.calendar_month_outlined)
                                      ),
                                      SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("This Month"),
                                          Text(
                                            "\$0.00",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          Text("0 transactions"),
                                        ],
                                      ),
                                    ],
                                  ),
                
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14.0,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white54
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(58, 33, 150, 243),
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        child: Icon(Icons.trending_up)
                                      ),
                                      SizedBox(width: 10.0,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Today's Orders"),
                                          Text(
                                            "0",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          Text("0 transactions"),
                                        ],
                                      ),
                                    ],
                                  ),
                
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14.0,
                                  )
                                ],
                              ),
                            ),
                
                          ],
                        ),
                      ),
                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(16.0),
                            padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
                            child: Text(
                              "Low Stock", 
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.fromLTRB(16.0,8.0,16.0,8.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: Column(
                              children: [
                                LowStockProduct(),
                                SizedBox(height: 10.0,),
                                LowStockProduct(),
                                SizedBox(height: 10.0,),
                                LowStockProduct(),
                              ],
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
