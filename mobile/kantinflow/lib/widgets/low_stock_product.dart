import 'package:flutter/material.dart';

class LowStockProduct extends StatelessWidget{

  final String productName;
  final double price;
  final int quantity;
  final String? imgUrl;

  const LowStockProduct({
    super.key,
    required this.productName,
    required this.price,
    required this.quantity,
    this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),                  
        border: Border.all(
          width: 1.0,
          color: Colors.white70,
        ),
        color: Colors.white,
        
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              (imgUrl == null)
              ?
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey,
                ),
              )
              :
              Image.network(
                imgUrl!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 8.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0
                    ),
                  ),
                  Text("₦$price")
                ],
              )
            ],
          ),

          Container(
            padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: const Color.fromARGB(127, 255, 214, 79)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16.0,
                ),
                SizedBox(width: 4.0,),
                Text("$quantity left")
              ],
            ),
          )
        ],
      ),
    );
  }
}