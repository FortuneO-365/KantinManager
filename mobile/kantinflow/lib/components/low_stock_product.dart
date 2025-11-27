import 'package:flutter/material.dart';

class LowStockProduct extends StatelessWidget{

  const LowStockProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),                  
        border: Border.all(
          width: 1.0,
          color: Colors.grey.shade300,
        ),
        color: Colors.grey.shade100,
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 8.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Coca-Cola",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0
                    ),
                  ),
                  Text("\$49.00")
                ],
              )
            ],
          ),

          Container(
            padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                width: 1.0,
                color: Colors.amber.shade500
              ),
              color: const Color.fromARGB(180, 255, 214, 79)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16.0,
                ),
                SizedBox(width: 4.0,),
                Text("2 left")
              ],
            ),
          )
        ],
      ),
    );
  }
}