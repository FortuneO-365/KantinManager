import 'package:flutter/material.dart';
import 'package:kantin_management/components/transaction_item.dart';

class SalesHistory extends StatelessWidget{
  const SalesHistory({super.key});

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
                  flex: 2,
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                )
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: ListView(
                children: [
                  TransactionItem(isOpen: false),
                  Divider(thickness: 1,height: 1,),
                  TransactionItem(isOpen: false),
                  Divider(thickness: 1,height: 1,),
                  TransactionItem(isOpen: false),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

