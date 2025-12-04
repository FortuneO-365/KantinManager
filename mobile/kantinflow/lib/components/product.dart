import 'package:flutter/material.dart';

class Product extends StatelessWidget{

  final String title;
  final String quantity;
  final String price;
  bool isLow = false;

  Product(this.title, this.quantity, this.price, this.isLow, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 16.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$$price',
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: isLow ? const Color.fromARGB(127, 255, 214, 79) : const Color.fromARGB(127, 100, 180, 246)
            ),
            child: Text(
              '$quantity in stock',
              style: TextStyle(
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}