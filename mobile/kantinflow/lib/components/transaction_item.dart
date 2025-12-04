import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget{

  bool isOpen = false;

  TransactionItem({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Mechanical Keyboard"
                      ),
                      SizedBox(height: 4.0,),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.blue.shade100
                          ),
                          SizedBox( width: 6.0,),
                          Text(
                            "0 minutes ago",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade100
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text("2"),
              ),
              Expanded(
                flex: 2,
                child: Text("\$12.00"),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      "\$24.00 ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(width: 4.0,),
                    Transform.rotate(
                      angle: isOpen ? 90 * 3.14 / 180 : 0,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14.0,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
          isOpen 
          ? Container(
            color: Color.fromARGB(255, 250, 250, 250),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _columnItem("Transation ID", "121212"),
                    SizedBox(width: 60.0,),
                    _columnItem("Product ID", "5"),
                  ],
                ),
                
                SizedBox( height: 12.0,),
                
                _columnItem("Date & Time","Mon, Dec 1, 2025, 11:08 AM"),

                SizedBox(height: 4.0,),
                Divider(thickness: 1,),
                SizedBox(height: 4.0,),
                
                _summaryRow("Unit Price", "\$12.00"),
                _summaryRow("Quantity", "x 2"),
                _summaryRow("SubTotal", "\$24.00"),
                _summaryRow("Tax (0%)", "\$0.00"),
                
                _summaryRow("Total Amount", "\$24.00", bold: true),
                  ],
                ),
              )
          : Container()
          
        ],

      ),
    );
  }
}

Widget _columnItem(String title, String value){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey
        ),
      ),
      SizedBox(height: 4.0,),
      Text(
        value,
        style: TextStyle(
          fontSize: 14.0
        ),
      )
    ],
  );
}

Widget _summaryRow(String label, String value, {bool bold = false}){
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: bold ? 16: 14,
            color: Colors.grey
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 16: 14,
          ),
        ),
      ],
    ),
  );
}