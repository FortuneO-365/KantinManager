import 'package:flutter/material.dart';
import 'package:kantin_management/components/transaction_item.dart';
import 'package:kantin_management/models/sales_model.dart';
import 'package:kantin_management/services/api_services.dart';

class SalesHistory extends StatelessWidget{
  SalesHistory({super.key});

  List<SalesModel> sales = [];

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

  List<String> productNames = [];

  Future<String> getProductNamebyId(int id, BuildContext context) async{
    final data = await ApiServices().getProduct(productId: id);

    if(data is! Map ){
      showToast(context, "Unable to get product details");
      return "Unknown";
    }

    return data["name"] ?? "Unknown";
  }

  Future<List<SalesModel>> loadSales(BuildContext context) async{
    final data =  await ApiServices().getSalesData();

    sales = (data as List)
      .map((item) => SalesModel.fromJson(item))
      .toList();

    for(var sale in sales){
      sale.productName = await getProductNamebyId(sale.productId, context);
    }
    
    return sales;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadSales(context),
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
              "Transaction History",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.grey,
                width: 2.0
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(16.0),
                        child: Text(
                          "Product",
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Qty",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Total Price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey,
                ),
                sales.isNotEmpty
                ?
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: sales.length,
                    itemBuilder: (context, index){
                      final sale = sales[index];
                      return Column(
                        children: [
                          TransactionItem(
                            sale: sale,
                          ),
                          Divider(thickness: 1,height: 1,),
                        ],
                      );
                    },
                  ),
                )
                :
                Expanded(
                  child: Column(
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
                          "You haven't made any sale yet",
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ),
                    ]
                  ),
                )
              ],
            ),
          )
        );
      }
    );
  }
}

