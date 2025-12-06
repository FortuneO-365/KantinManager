import 'package:flutter/material.dart';
import 'package:kantin_management/components/low_stock_product.dart';
import 'package:kantin_management/models/dashboard_stats.dart';
import 'package:kantin_management/services/api_services.dart';

class Dashboard extends StatelessWidget {
  final String name;

  const Dashboard({super.key, required this.name});

  Future<DashboardStats> loadTotalSales() async {
    dynamic data = await ApiServices().getDashboardSummary();
    DashboardStats stats = DashboardStats.fromJson(data);
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadTotalSales(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (snapshot.hasError) {
        return Scaffold(
          body: Center(child: Text("Error: ${snapshot.error}")),
        );
      }

      if (!snapshot.hasData) {
        return const Scaffold(
          body: Center(child: Text("No data found")),
        );
      }

      final stats = snapshot.data!;
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
                            Text(
                              'Hello, $name!', 
                              style: const TextStyle(
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
                                        '${stats.totalSales}',
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
                                        "₦${stats.totalRevenue}",
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
                                                "₦${stats.totalToday}",
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
                                                "₦${stats.totalMonth}",
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
                                                "${stats.todayOrders!.length} sales",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.0
                                                ),
                                              ),
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
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 245, 245, 245),
                                  borderRadius: BorderRadius.circular(8.0)
                                ),
                                child: (stats.lowStock != null && stats.lowStock!.isNotEmpty)
                                  ?
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    itemCount: stats.lowStock!.length,
                                    itemBuilder: (context, index) {
                                      final product = stats.lowStock![index];
                                      return Column(
                                        children: [
                                          LowStockProduct(), 
                                          SizedBox(height: 10.0,),
                                        ],
                                      );
                                    }, 
                                  )
                                  :
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      Container(
                                        width:50,
                                        height: 50,
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(29, 100, 180, 246),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Icon(
                                          Icons.archive_outlined,
                                          size: 26.0,
                                        ),
                                      ),
                                      SizedBox(height: 16.0,),
                                      Center(
                                        child: Text(
                                          "You don't have any low stock",
                                          style: TextStyle(
                                            color: Colors.grey
                                          ),
                                        ),
                                      ),
                                    ]
                                  )
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
    );
  }
}
